//
//  HoldingsInteractor.swift
//  Nishantkumar Rai Task
//
//  Created by Nishant Rai on 14/12/24.
//

import CoreData
import Network
import UIKit

protocol HoldingsInteractorProtocol: AnyObject {
    func fetchHoldings()
    func getHoldingsSummary(_ holdings: [UserHoldings])
}

class HoldingsInteractor: HoldingsInteractorProtocol {
    weak var presenter: HoldingsPresenterProtocol?
    private let coreDataService: CoreDataServiceProtocol
    
    init(presenter: HoldingsPresenterProtocol? = nil, coreDataService: CoreDataServiceProtocol) {
        self.presenter = presenter
        self.coreDataService = coreDataService
    }
    
    func fetchHoldings() {
        fetchHoldingsFromAPI()
    }
    
    func fetchHoldingsFromAPI() {
        guard let url = URL(string: APIConstants.holdingsListURL) else {
            presenter?.didFailToFetchHoldings(error: APIError.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            if let error = error {
                // Show cache data and alert when internet connection appears to be offline
                getHoldingsSummary(coreDataService.fetchCachedData())
                self.presenter?.didFetchHoldings(holdings: coreDataService.fetchCachedData())
                self.presenter?.didFailToFetchHoldings(error: APIError.networkUnavailable(reason: error.localizedDescription))
                return
            }
            guard let data = data else {
                self.presenter?.didFailToFetchHoldings(error: .custom(message: APIErrorsText.apiErrorUnableToFetchYourHoldings))
                return
            }
            do {
                let decodedHoldings = try JSONDecoder().decode(HoldingsEntities.self, from: data)
                DispatchQueue.global(qos: .background).async {
                    self.coreDataService.save(data: decodedHoldings.data.userHolding)
                }
                getHoldingsSummary(decodedHoldings.data.userHolding)
                self.presenter?.didFetchHoldings(holdings: decodedHoldings.data.userHolding)
            } catch {
                self.presenter?.didFailToFetchHoldings(error: APIError.requestFailed(reason: error.localizedDescription))
            }
        }.resume()
    }
    
    
    func getHoldingsSummary(_ holdings: [UserHoldings]) {
        // 1. Current Value of Holdings
        let currentValue = holdings.reduce(0.0) { result, holding in
            result + (holding.ltp * Double(holding.quantity))
        }
        // 2. Total Investments
        let totalInvesments = holdings.reduce(0.0) { result, holding in
            result + (holding.avgPrice * Double(holding.quantity))
        }
        // 3. Total PNL
        let totalPNL = currentValue - totalInvesments
        
        // 4. Today's PNL
        let todaysPNL = holdings.reduce(0.0) { result, holding in
            result + ((holding.close - holding.ltp) * Double(holding.quantity))
        }
        self.presenter?.didCalculateHoldingsSummary(
            currentValue: currentValue,
            totalInvesment: totalInvesments,
            toalPNL: totalPNL,
            todaysPNL: todaysPNL
        )
    }
}
