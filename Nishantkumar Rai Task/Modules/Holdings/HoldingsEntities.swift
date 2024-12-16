//
//  HoldingsEntities.swift
//  Nishantkumar Rai Task
//
//  Created by Nishant Rai on 14/12/24.
//

import UIKit

struct HoldingsEntities: Codable {
    let data: Holdings
}

struct Holdings: Codable {
    let userHolding: [UserHoldings]
}

struct UserHoldings: Codable {
    let symbol: String
    let quantity: Int
    let ltp, avgPrice, close: Double
    private var profitLoss: Double {
        (ltp - avgPrice) * Double(quantity)
    }
    var pnl: String {
        return CommonUtils.getFormatterNumberWithAppendedSymbolString(from: profitLoss)
    }
    var pnlColor: UIColor {
        return profitLoss >= 0 ? FontColors.profitIndicationColor : FontColors.lossIndicationColor
    }
}

struct HoldingsSummary {
    let currentValue,
        totalInvestment,
        totalPNL,
        todaysPNL : String?
}

struct BottomSheetModel {
    let title: String
    let value: String
}
