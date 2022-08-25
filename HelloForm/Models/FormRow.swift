import UIKit

public protocol FormRowBase {}

public protocol FormRow: FormRowBase {
    var image: UIImage? { get }
    var action: (() -> Void)? { get }
    var detailDisclosureButtonAction: (() -> Void)? { get }
    var edgeInsets: UIEdgeInsets { get }
    var _backgroundColor: UIColor? { get }
    var _tintColor: UIColor { get }
    var _accessoryType: UITableViewCell.AccessoryType { get }
    var _selectionStyle: UITableViewCell.SelectionStyle { get }
    var _deselectWhenSelect: Bool { get }
    var _isHiddenSeparator: Bool { get }
    var _reloadRowAnimation: UITableView.RowAnimation { get }
    var _tag: String? { get }
}

public class Row: FormRow, FormRowModifier {
    
    // MARK: - Properties
    public var image: UIImage? = nil
    public var action: (() -> Void)? = nil
    public var detailDisclosureButtonAction: (() -> Void)? = nil
    public var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    public var _backgroundColor: UIColor?
    public var _tintColor: UIColor = .systemBlue
    public var _accessoryType: UITableViewCell.AccessoryType = .none
    public var _selectionStyle: UITableViewCell.SelectionStyle = .default
    public var _deselectWhenSelect: Bool = false
    public var _isHiddenSeparator: Bool = false
    public var _reloadRowAnimation: UITableView.RowAnimation = .automatic
    public var _tag: String? = nil
    @Pub public private(set) var isHiddenRow: Bool = false
    
    // MARK: - Initializers
    
    public init(image: UIImage? = nil) {
        self.image = image
    }
    
    // MARK: - Modifiers
    
    @discardableResult
    public func padding(top: CGFloat = 12, leading: CGFloat = 16, bottom: CGFloat = 12, trailing: CGFloat = 16) -> Row {
        self.edgeInsets = UIEdgeInsets(top: top, left: leading, bottom: bottom, right: trailing)
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ color: UIColor) -> Row {
        self._backgroundColor = color
        return self
    }
    
    @discardableResult
    public func tintColor(_ color: UIColor) -> Row {
        self._tintColor = color
        return self
    }
    
    @discardableResult
    public func accessoryType(_ accessoryType: UITableViewCell.AccessoryType) -> Row {
        self._accessoryType = accessoryType
        return self
    }
    
    @discardableResult
    public func selectionStyle(_ selectionStyle: UITableViewCell.SelectionStyle) -> Row {
        self._selectionStyle = selectionStyle
        return self
    }
    
    @discardableResult
    public func deselectWhenSelect(_ flag: Bool) -> Row {
        self._deselectWhenSelect = flag
        return self
    }
    
    @discardableResult
    public func addAction(_ action: @escaping () -> Void) -> Row {
        self.action = action
        return self
    }
    
    @discardableResult
    public func addDetailDisclosureButtonAction(_ action: @escaping () -> Void) -> Row {
        self.detailDisclosureButtonAction = action
        return self
    }
    
    @discardableResult
    public func hideSeparators() -> Row {
        self._isHiddenSeparator = true
        return self
    }
    
    @discardableResult
    public func reloadRowAnimation(_ animation: UITableView.RowAnimation) -> Row {
        self._reloadRowAnimation = animation
        return self
    }
    
    @discardableResult
    public func hidden(_ flag: Pub<Bool>) -> Row {
        self._isHiddenRow = flag
        return self
    }
    
    @discardableResult
    public func tag(_ tag: String) -> Row {
        self._tag = tag
        return self
    }
    
}

