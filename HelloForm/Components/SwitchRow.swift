import UIKit

public final class SwitchRow: Row, SwitchRowModifier {
    
    private(set) var title: String
    @Pub private(set) var isOn: Bool
    
    private(set) var _font: UIFont = .preferredFont(forTextStyle: .body)
    private(set) var _textColor: UIColor = UIColor.SystemColor.label
    
    // MARK: - Initializers
    
    public init(_ title: String, isOn: Pub<Bool>, image: UIImage? = nil) {
        self.title = title
        self._isOn = isOn
        
        super.init(image: image)
    }
    
    // MARK: - Modifiers
    
    @discardableResult
    public func font(_ font: UIFont) -> Row {
        self._font = font
        return self
    }
    
    @discardableResult
    public func textColor(_ color: UIColor) -> Row {
        self._textColor = color
        return self
    }
    
    // MARK: - Public methods
    
    public func changeValue(to newValue: Bool) {
        self.isOn = newValue
    }
    
}
