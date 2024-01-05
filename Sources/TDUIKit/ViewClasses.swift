//
//  ViewClasses.swift
//  
//
//  Created by Sherlock on 2024/1/5.
//

import Foundation
import UIKit
import TDStability
import SnapKit
import TDFoundation

open class ViewController: UIViewController {
    
    public var onoView = UIView.init()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.do {
            $0.view.do {
                $0.td.add(onoView) {
                    if #available(iOS 11.0, *) {
                        $0.edges.equalTo(self.view.safeAreaLayoutGuide)
                    } else {
                        $0.edges.equalTo(self.view)
                    }
                }
            }
            
            $0.assembling()
        }
    }
    
    open func assembling() { _fatailError(" Must Need Override 'assembling(_ rect: CGRect)' ", value: ()) }
    
}

@objc public protocol DataLoadable: AnyObject {
    
    /// Load the newest data
    func loadNewData()
    
    /// Load the more data
    func loadMoreData()
    
    /// Load data depend the parameter of `new`
    ///
    /// - Parameter new: Whether is new
    func loadDataOf(new: Bool)
    
}

extension ViewController: DataLoadable {
    
    @objc public func loadNewData() {
        loadDataOf(new: true)
    }
    
    @objc public func loadMoreData() {
        loadDataOf(new: false)
    }
    
    @objc open func loadDataOf(new: Bool = true) {_fatailError("controller 需要在使用 refreasher 后重写该方法", value: "") }
    
}

/// A view extension `UIView` and `ViewAssemble`. must override `assembling(_ rect: CGRect)`
///
/// Like:
///
///     class AView: ViewAssmbled {
///
///         override func assembling(_ rect: CGRect) {
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
open class ViewAssmbled: UIView, ViewAssemble {
    
    open override var backgroundColor: UIColor? {
        get { return super.backgroundColor }
        set { }
    }
    
    public var lockedBackgroundColor: UIColor? {
        set { super.backgroundColor = newValue }
        get { return super.backgroundColor }
    }
    
    public override init(frame: CGRect) { super.init(frame: frame); assembling(frame) }
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); assembling(CGRect.zero) }
    
    public init() { super.init(frame: CGRect.zero); assembling(CGRect.zero) }
    
    open func assembling(_ rect: CGRect) { _fatailError(" Must Need Override 'assembling(_ rect: CGRect)' ", value: ()) }
}

/// A view extension `ViewAssmbled` and `ViewIndieable`. must override `assembling(_ rect: CGRect)`
///
/// Like:
///
///     class BView: ViewIndie<DataModel> {
///
///         var label = UILabel.init()
///
///         override var model: DataModel? {
///             didSet {
///                 label.text = model?.name
///             }
///         }
///
///         override func assembling(_ rect: CGRect) {
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
open class ViewIndie<T>: ViewAssmbled, ViewIndieable {
    
    open var model: T?
}

/// A Cell extension `UITableViewCell` and `CellIndieable`. must override `assembling(_ rect: CGRect)`
///
/// Like:
///
///     class TableViewCell: TableViewCellIndie<DataModel> {
///
///         var identifier: String { return "lalala" }
///
///         override var model: DataModel? {
///             didSet {
///
///             }
///         }
///
///         override func assembling(_ rect: CGRect) {
///             // do something
///         }
///
///         static func sizeForCell(model: DataModel?) -> CGSize {
///             return CGSize.zero
///         }
///     }
open class TableViewCellIndie<T>: UITableViewCell, CellIndieable {
    
    open var model: T?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier); assembling(CGRect.zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder); assembling(CGRect.zero)
    }
    
    open func assembling(_ rect: CGRect) { _fatailError(" Must Need Override 'assembling(_ rect: CGRect)' ", value: ()) }
}

/// A Cell extension `UICollectionViewCell` and `CellIndieable`. must override `assembling(_ rect: CGRect)`
///
/// Like:
///
///     class CollectionViewCell: CollectionViewCell<DataModel> {
///
///         var identifier: String { return "lalala" }
///
///         override var model: DataModel? {
///             didSet {
///
///             }
///         }
///
///         override func assembling(_ rect: CGRect) {
///             // do something
///         }
///
///         static func sizeForCell(model: DataModel?) -> CGSize {
///             return CGSize.zero
///         }
///     }
open class CollectionViewCell<T>: UICollectionViewCell, CellIndieable {
    
    open var model: T?
    
    public override init(frame: CGRect) { super.init(frame: frame); assembling(frame) }
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); assembling(CGRect.zero) }
    
    open func assembling(_ rect: CGRect) { _fatailError(" Must Need Override 'assembling(_ rect: CGRect)' ", value: ()) }
}

open class TableViewHeaderFooterView<T>: UITableViewHeaderFooterView, CellIndieable {
    open var model: T?
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier); assembling(frame)
    }
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); assembling(CGRect.zero) }
    open func assembling(_ rect: CGRect) { _fatailError(" Must Need Override 'assembling(_ rect: CGRect)' ", value: ()) }
}

open class CollectionReusableView<T>: UICollectionReusableView, CellIndieable {
    open var model: T?
    
    public override init(frame: CGRect) { super.init(frame: frame); assembling(frame) }
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); assembling(CGRect.zero) }
    open func assembling(_ rect: CGRect) { _fatailError(" Must Need Override 'assembling(_ rect: CGRect)' ", value: ()) }
}
