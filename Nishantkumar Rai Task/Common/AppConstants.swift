//
//  AppConstants.swift
//  Nishantkumar Rai Task
//
//  Created by Nishant Rai on 14/12/24.
//

import UIKit

struct APIConstants {
    static let holdingsListURL = "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io"
}
struct NumberConstants {
    static let zero = 0.0
}

struct UIConstants {
    static let defaultTopSpace = 16.0
    static let defaultBottomSpace = 16.0
    static let defaultLeadingSpace = 16.0
    static let defaultTrailingSpace = 16.0
    static let defaultVerticalStackSpace = 24.0
    static let defaultHorizontalStackSpace = 4.0
    static let defaultCornerRadius = 8.0
}

struct FontSizes {
    static let regularTitle = 12.0
    static let mediumTitle = 16.0
    static let largeTitle = 18.0
}

struct FontColors {
    static let defaultTitleColor = UIColor.lightGray
    static let defaultDarkTextTitleColor = UIColor.darkGray
    static let defaultValueColor = UIColor.black
    static let profitIndicationColor = UIColor.systemGreen
    static let lossIndicationColor = UIColor.red
}

struct LabelText {
    static let netQty = NSLocalizedString("netQty", comment: "net qty title")
    static let ltp = NSLocalizedString("ltp", comment: "Last traded price title")
    static let profitAndLoss = NSLocalizedString("p&l", comment: "profit and loss title")
    static let rupeeSymbol = NSLocalizedString("rupee", comment: "rupee symbol")
    static let holdingsTitle = NSLocalizedString("holdingsTitle", comment: "holdings screen title")
    static let currentValue = NSLocalizedString("currentValue", comment: "current Value title")
    static let totalInvestment = NSLocalizedString("totalInvestment", comment: "total Investment title")
    static let todayPNL = NSLocalizedString("todayPNL", comment: "today's profit & loss title")
    static let pnl = NSLocalizedString("pnl", comment: "profit & loss title")
}

struct APIErrorsText {
    static let apiErrorUnableToFetchYourHoldings = NSLocalizedString("apiErrorUnableToFetchYourHoldings", comment: "Api Error Unable To Fetch Your Holdings")
}

struct ImageAssets {
    static let upArrow = UIImage(systemName: "arrow.up")
    static let downArrow = UIImage(systemName: "arrow.down")
}
