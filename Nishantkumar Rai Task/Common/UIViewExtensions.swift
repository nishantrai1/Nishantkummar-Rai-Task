//
//  UIViewExtensions.swift
//  Nishantkumar Rai Task
//
//  Created by Nishant Rai on 15/12/24.
//

import UIKit

extension UIView {
    func applyCornerRadius(_ radius: CGFloat, masksToBounds: Bool = true) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = masksToBounds
    }
}
