import UIKit

public protocol FormRowBase {}

public protocol FormRow: FormRowBase {
    var image: UIImage? { get set }
    var action: (() -> Void)? { get set }
    var detailDisclosureButtonAction: (() -> Void)? { get set }
    var edgeInsets: UIEdgeInsets { get set }
    var _backgroundColor: UIColor? { get set }
    var _tintColor: UIColor { get set }
    var _accessoryType: UITableViewCell.AccessoryType { get set }
    var _selectionStyle: UITableViewCell.SelectionStyle { get set }
    var _deselectWhenSelect: Bool { get set }
    var _isHiddenSeparator: Bool { get set }
    var _reloadRowAnimation: UITableView.RowAnimation { get set }
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
    
}

