//
//  Compatible.swift
//  
//
//  Created by Sherlock on 2024/1/4.
//

import Foundation
import UIKit
import TDStability
import SnapKit

// MARK: - Compatible for UIResponder

extension UIResponder: Compatible {}

// MARK: - UIView

extension TD where Base: UIView {
    
    /// 方便去 addsubview 同时配置约束布局条件
    ///
    /// - Parameters:
    ///   - view: 要添加的 subview
    ///   - closure: 约束 closure
    public func add(_ view: UIView, _ closure: ((ConstraintMaker) -> Void)? = nil) {
        // 如果已经添加到 superview 同时 superview != self， 以防止 'draw(_ rect: CGRect)' 重复调用
        guard view.superview != base else { return }
        view.removeFromSuperview()
        
        base.addSubview(view)
        guard let closure = closure else { return }
        
        view.snp.makeConstraints(closure)
    }
}


