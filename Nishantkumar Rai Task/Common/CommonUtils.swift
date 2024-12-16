//
//  CommonUtils.swift
//  Nishantkumar Rai Task
//
//  Created by Nishant Rai on 15/12/24.
//

import UIKit

struct CommonUtils {
    static func getTextWithAsterisk(to text: String, baselineOffset: CGFloat = 5, fontSize: CGFloat = 12
       ) -> NSAttributedString {
           let attributedString = NSMutableAttributedString(string: text)
           let asteriskAttributes: [NSAttributedString.Key: Any] = [
               .baselineOffset: baselineOffset,
               .font: UIFont.systemFont(ofSize: fontSize)
           ]
           let superscriptAsterisk = NSAttributedString(string: "*", attributes: asteriskAttributes)
           attributedString.append(superscriptAsterisk)
           return attributedString
       }
    
    static func getFormatterNumberWithAppendedSymbolString(from number: Double, with symbol: String = LabelText.rupeeSymbol
    ) -> String {
        let formattedNumber = abs(number)
        let formatter = String(format: "%.2f", formattedNumber)
        let sign = number < 0 ? "-" : ""
        return sign + symbol + formatter
    }
}
