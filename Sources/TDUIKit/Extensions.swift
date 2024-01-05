//
//  Extensions.swift
//  
//
//  Created by Sherlock on 2024/1/5.
//

import Foundation
import UIKit
import TDStability

extension UIColor {
    
    /// 创建 UIColor
    /// For example:
    ///
    ///     let color1 = UIColor(hexString: "FF261B")
    ///     let color2 = UIColor(hexString: "#FF261B")
    ///     let color3 = UIColor(hexString: "FF261BFF")
    ///     let color3 = UIColor(hexString: "#FF261BFF")
    /// - Parameter hexString: 十六进制
    public convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") { scanner.scanLocation = 1 }
        
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) { self.init(hex: color, useAlpha: hexString.count > 7) }
        else { self.init(hex: 0x000000) }
    }
    
    /// 创建 UIColor
    ///
    /// - Parameters:
    ///   - hex: 十六进制
    ///   - alphaChannel: 十六进制中是否包括透明
    public convenience init(hex: UInt32, useAlpha alphaChannel: Bool = false) {
        let mask = 0xff
        let r = Int(hex >> (alphaChannel ? 24 : 16)) & mask
        let g = Int(hex >> (alphaChannel ? 16 : 8)) & mask
        let b = Int(hex >> (alphaChannel ? 8 : 0)) & mask
        let a = alphaChannel ? Int(hex) & mask : 255
        
        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255
        let alpha = CGFloat(a) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The shorthand three-digit hexadecimal representation of color.
     #RGB defines to the color #RRGGBB.
     
     - parameter hex3: Three-digit hexadecimal value.
     - parameter alpha: 0.0 - 1.0. The default is 1.0.
     */
    public convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue    = CGFloat( hex3 & 0x00F      ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


// MARK: - Then

extension Then where Self: UITableViewCell {
    
    
    /// 方便去 给 cell 赋值属性
    /// For example:
    ///     return tableView.dequeueReusableCell(withIdentifier: "HomeContentCell", for: indexPath).then({ (cell: HomeContentCell?) in
    ///         cell?.todo...
    ///     })
    ///
    /// - Parameter closure: 赋值 closure
    public func then<T: UITableViewCell>(_ closure:(T?) -> Void) -> Self {
        closure(self as? T)
        return self
    }
}

extension Then where Self: UITableViewHeaderFooterView {
    
    /// 方便去 给 headerfooter 赋值属性
    /// For example:
    ///     return tableView.dequeueReusableHeaderFooterView(withIdentifier: "xxx", for: indexPath).then({ (header: HomeHeader?) in
    ///         header?.todo...
    ///     })
    ///
    /// - Parameter closure: 赋值 closure
    public func then<T: UITableViewHeaderFooterView>(_ closure:(T?) -> Void) -> Self {
        closure(self as? T)
        return self
    }
}

extension Then where Self: UICollectionViewCell {
    
    /// 方便去 给 cell 赋值属性
    /// For example:
    ///     return collectionView.dequeueReusableCell(withIdentifier: "HomeContentCell", for: indexPath).then({ (cell: HomeContentCell?) in
    ///         cell?.todo...
    ///     })
    ///
    /// - Parameter closure: 赋值 closure
    public func then<T: UICollectionViewCell>(_ closure:(T?) -> Void) -> Self {
        closure(self as? T)
        return self
    }
}

extension Then where Self: UICollectionReusableView {
    
    /// 方便去 给 cell 赋值属性
    /// For example:
    ///     return collectionView.dequeueReusableCell(withIdentifier: "HomeContentCell", for: indexPath).then({ (cell: HomeContentCell?) in
    ///         cell?.todo...
    ///     })
    ///
    /// - Parameter closure: 赋值 closure
    public func then<T: UICollectionReusableView>(_ closure:(T?) -> Void) -> Self {
        closure(self as? T)
        return self
    }
}
