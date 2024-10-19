//
//  Extension.swift
//  Climat
//
//  Created by Юлия Кагирова on 16.10.2024.
//

import UIKit

extension String {
    var localized: String {
        NSLocalizedString(self, comment: self)
    }
}

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for i in subviews {
            self.addSubview(i)
        }
    }
}
