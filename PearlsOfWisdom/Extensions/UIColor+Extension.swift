//
//  UIColor+Extension.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Səfərli on 10.11.22.
//

import Foundation
import UIKit

extension UIColor {
    static let backgroundColor = UIColor(hex: "#557153")
    static let secondaryBackgroundColor = UIColor(hex: "#7D8F69")
    
    static let actionColor = UIColor(hex: "#E6E5A3")
    static let secondaryActionColor = UIColor(hex: "#A9AF7E")
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
      var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      
      if cString.hasPrefix("#") { cString.removeFirst() }
      
      if cString.count != 6 {
        self.init(hex: "ff0000") // return red color for wrong hex input
        return
      }
      
      var rgbValue: UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)
      
      self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: alpha)
    }
}
