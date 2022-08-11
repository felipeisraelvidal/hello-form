import UIKit

public protocol DeclarativeView {
    associatedtype View: UIView
    
    func fillSuperview(offset: CGFloat) -> View
    func setWidth(_ width: CGFloat) -> View
    func setHeight(_ height: CGFloat) -> View
    func setCornerRadius(_ cornerRadius: CGFloat) -> View
    func setBackgroundColor(_ color: UIColor) -> View
}

public protocol DeclarativeLabel {
    associatedtype View: UILabel
    
    func setText(_ text: String) -> View
    func setFont(_ font: UIFont) -> View
    func setTextColor(_ color: UIColor) -> View
}
