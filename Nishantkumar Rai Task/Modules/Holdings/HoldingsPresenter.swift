//
//  HoldingsPresenter.swift
//  Nishantkumar Rai Task
//
//  Created by Nishant Rai on 14/12/24.
//
import UIKit

protocol HoldingsPresenterProtocol: AnyObject {
    func loadHoldings()
    func didFailToFetchHoldings(error: APIError)
    func didFetchHoldings(holdings: [UserHoldings])
    func didCalculateHoldingsSummary(currentValue: Double, totalInvesment: Double, toalPNL: Double, todaysPNL: Double)
    func didTapOnHoldingSummaryView()
}

class HoldingsPresenter: HoldingsPresenterProtocol {
    weak var view: HoldingsViewProtocol?
    var interactor: HoldingsInteractorProtocol?
    var router: HoldingsRouter?
    private var isHoldingsSummaryVisible = false
    
    func loadHoldings() {
        interactor?.fetchHoldings()
    }
    
    func didFailToFetchHoldings(error: APIError) {
        DispatchQueue.main.async {
            self.view?.showError(error.localizedErrorDescription)
        }
    }
    
    func didFetchHoldings(holdings: [UserHoldings]) {
        DispatchQueue.main.async {
            self.view?.showHoldings(holdings)
        }
    }
    
    func didCalculateHoldingsSummary(currentValue: Double, totalInvesment: Double, toalPNL: Double, todaysPNL: Double) {
        var holdingsSummary: [BottomSheetModel] = []
        holdingsSummary.append(BottomSheetModel(title: LabelText.currentValue, value: CommonUtils.getFormatterNumberWithAppendedSymbolString(from: currentValue)))
        holdingsSummary.append(BottomSheetModel(title: LabelText.totalInvestment, value: CommonUtils.getFormatterNumberWithAppendedSymbolString(from: totalInvesment)))
        holdingsSummary.append(BottomSheetModel(title: LabelText.todayPNL, value: CommonUtils.getFormatterNumberWithAppendedSymbolString(from: todaysPNL)))
        DispatchQueue.main.async {
            self.view?.showHoldingsSumary(holdingsSummary: holdingsSummary, totalPNLTitle: LabelText.pnl, totalPNL: CommonUtils.getFormatterNumberWithAppendedSymbolString(from: toalPNL))
        }
    }
    
    func didTapOnHoldingSummaryView() {
        isHoldingsSummaryVisible.toggle()
        view?.shouldShowHoldingSummaryView(isHoldingsSummaryVisible)
    }
}
