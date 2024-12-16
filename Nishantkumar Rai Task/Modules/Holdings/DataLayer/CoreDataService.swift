//
//  CoreDataService.swift
//  Nishantkumar Rai Task
//
//  Created by Nishant Rai on 15/12/24.
//
import UIKit
import CoreData

protocol CoreDataServiceProtocol {
    func save(data: [UserHoldings])
    func fetchCachedData() -> [UserHoldings]
}

class CoreDataService: CoreDataServiceProtocol {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(data: [UserHoldings]) {
        // Delete old cache data
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = UserHoldingsData.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            debugPrint("Failed to delete old cache data: \(error)")
        }
        // Cache New Data
        for holdings in data {
            let userHoldingsData = UserHoldingsData(context: context)
            userHoldingsData.updateUserHoldings(with: holdings)
        }
        do {
            try context.save()
        } catch {
            debugPrint("Failed to save data: \(error)")
        }
    }
    
    func fetchCachedData() -> [UserHoldings] {
        let fetchRequest: NSFetchRequest<UserHoldingsData> = UserHoldingsData.fetchRequest()
        do {
            let userHoldings = try context.fetch(fetchRequest)
            return userHoldings.map({$0.toUserHoldings()})
        } catch {
            debugPrint("Failed to fetch data: \(error)")
            return []
        }
    }
    
}

extension UserHoldingsData {
    func toUserHoldings() -> UserHoldings {
        return UserHoldings(
            symbol: self.symbol ?? "",
            quantity: Int(self.quantity),
            ltp: self.ltp,
            avgPrice: self.avgPrice,
            close: self.close
        )
    }
    
    func updateUserHoldings(with UserHoldings: UserHoldings) {
        self.symbol = UserHoldings.symbol
        self.quantity = Int32(UserHoldings.quantity)
        self.ltp = UserHoldings.ltp
        self.avgPrice = UserHoldings.avgPrice
        self.close = UserHoldings.close
    }
}
