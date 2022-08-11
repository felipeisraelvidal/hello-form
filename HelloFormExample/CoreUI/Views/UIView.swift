import UIKit

extension UIView: DeclarativeView {
    
    @discardableResult
    public func fillSuperview(offset: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        
        guard let superview = superview else {
            return self
        }
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: offset),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: offset),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -offset),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: offset)
        ])
        
        return self
    }
    
    @discardableResult
    public func setWidth(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    public func setHeight(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    public func setCornerRadius(_ cornerRadius: CGFloat) -> UIView {
        self.layer.cornerRadius = cornerRadius
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(_ color: UIColor) -> UIView {
        self.backgroundColor = color
        return self
    }
    
}
