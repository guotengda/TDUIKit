//
//  ViewProtocols.swift
//  
//
//  Created by Sherlock on 2024/1/5.
//

import Foundation
import UIKit

/// A protocol used to assmbling a view in `init()` function
///
/// Use like:
///
///     class AView: UIView, ViewAssemble {
///
///         override init(frame: CGRect) {
///             super.init(frame: frame)
///             // custom initialize
///             // assmbly subviews
///             assembling(CGRect.init(origin: CGPoint.zero, size: frame.size))
///         }
///
///         required init?(coder aDecoder: NSCoder) {
///             super.init(coder: aDecoder)
///             // custom initialize
///             // assmbly subviews
///             assembling(CGRect.zero)
///         }
///
///         func assembling(_ rect: CGRect) {
///             self.do {
///                 $0.td.add(UIView.init().then {
///                     $0.backgroundColor = UIColor.red
///                     $0.layer.borderColor = UIColor.green.cgColor
///                     $0.layer.borderWidth = 1
///                 }) {
///                     $0.center.equalToSuperview()
///                     $0.width.height.equalTo(rect.size).multipliedBy(0.5)
///                 }
///             }
///         }
///     }
public protocol ViewAssemble: AnyObject {
    
    /// Assemby all view's subview and itself propertys whick you need.
    ///
    /// - Warning
    ///     must call this in view's init funciton or where can confirm will not repeat call for avoid waste
    ///
    /// - Note
    ///     default implementation is do nothing
    ///
    /// - Parameter rect: the view's bounds
    func assembling(_ rect: CGRect)
}

/// A protocol inherit `ViewAssemble`, used to indie views from a view model and use `indieDecorate(model: T)` to updated view
///
/// Use like:
///
///     struct DataModel {
///         var name: String = ""
///     }
///
///     class BView: UIView, ViewIndieable {
///
///         var label = UILabel.init()
///
///         var model: DataModel? {
///             didSet {
///                 label.text = model?.name
///             }
///         }
///
///         override init(frame: CGRect) {
///             super.init(frame: frame)
///             // custom initialize
///             // assmbly subviews
///             assembling(CGRect.init(origin: CGPoint.zero, size: frame.size))
///         }
///
///         required init?(coder aDecoder: NSCoder) {
///             super.init(coder: aDecoder)
///             // custom initialize
///             // assmbly subviews
///             assembling(CGRect.zero)
///         }
///
///         func assembling(_ rect: CGRect) {
///             self.do {
///                 $0.td.add(label.then {
///                     $0.font = UIFont.systemFont(ofSize: 12)
///                 }) {
///                     $0.center.equalToSuperview()
///                     $0.width.height.equalTo(rect.size).multipliedBy(0.5)
///                 }
///             }
///         }
///     }
///
/// And use function `indieDecorate(model: T?)` to set model like:
///
///     bView.indeiDecorate(DataModel.init())
public protocol ViewIndieable: ViewAssemble {
    
    associatedtype T
    
    /// The data model for showed
    var model: T? { get set }
    
    /// Decorate the model to the view, always use model's `didSet` to refresh the view
    /// - Note
    ///     default implementation is do nothing
    func indieDecorate(model: T?)
}

public extension ViewIndieable {
    func indieDecorate(model: T?) { self.model = model }
}

/// A protocol used for `UITableViewCell`, 'UICollectionViewCell', `UITableViewHeaderFooterView` etc.
public protocol Identifiable {
    
    /// The identifier for cell, used for `dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath)`
    ///
    /// - Returns: The identifier for cell, `type(of: self)` by default
    static var identifier: String { get }
    
}

 public extension Identifiable {
    
    static var identifier: String { return "\(type(of: self))" }
    
}

/// A protocol inherit `ViewIndieable`, used for `UITableViewCell` or 'UICollectionViewCell'
public protocol CellIndieable: ViewIndieable, Identifiable {
    
    /// Return size for cell need by data model
    /// - Note
    ///     default implementation is `CGSize.zero`
    static func sizeForCell(model: T?) -> CGSize
}

public extension CellIndieable {
    
    static func sizeForCell(model: T?) -> CGSize { return CGSize.zero }
}


