import UIKit

public final class TextFieldRow: Row, TextFieldModifier {
    
    private(set) var placeholder: String
    @Pub private(set) var text: String
    
    private(set) var _font: UIFont = .preferredFont(forTextStyle: .body)
    private(set) var _textColor: UIColor = UIColor.SystemColor.label
    private(set) var _textAlignment: NSTextAlignment = .natural
    
    private(set) var _textFieldStyle: UITextField.BorderStyle = .none
    private(set) var _returnKeyType: UIReturnKeyType = .default
    private(set) var _autocapitalizationType: UITextAutocapitalizationType = .sentences
    private(set) var _autocorrectionType: UITextAutocorrectionType = .default
    private(set) var _clearButtonMode: UITextField.ViewMode = .never
    
    private(set) var onSubmitAction: ((String) -> Void)?
    
    // MARK: - Initializers
    
    public init(_ placeholder: String, text: Pub<String>, image: UIImage? = nil) {
        self.placeholder = placeholder
        self._text = text
        
        super.init(image: image)
    }
    
    // MARK: - Modifiers
    
    @discardableResult
    public func font(_ font: UIFont) -> TextFieldRow {
        self._font = font
        return self
    }
    
    @discardableResult
    public func textColor(_ color: UIColor) -> TextFieldRow {
        self._textColor = color
        return self
    }
    
    @discardableResult
    public func textAlignment(_ alignment: NSTextAlignment) -> TextFieldRow {
        self._textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func textFieldStyle(_ style: UITextField.BorderStyle) -> TextFieldRow {
        self._textFieldStyle = style
        return self
    }
    
    @discardableResult
    public func returnKeyType(_ type: UIReturnKeyType) -> TextFieldRow {
        self._returnKeyType = type
        return self
    }
    
    @discardableResult
    public func autocapitalizationType(_ type: UITextAutocapitalizationType) -> TextFieldRow {
        self._autocapitalizationType = type
        return self
    }
    
    @discardableResult
    public func autocorrectionType(_ type: UITextAutocorrectionType) -> TextFieldRow {
        self._autocorrectionType = type
        return self
    }
    
    @discardableResult
    public func clearButtonMode(_ mode: UITextField.ViewMode) -> TextFieldRow {
        self._clearButtonMode = mode
        return self
    }
    
    @discardableResult
    public func onSubmit(_ action: @escaping ((String) -> Void)) -> TextFieldRow {
        self.onSubmitAction = action
        return self
    }
    
    // MARK: - Public methods
    
    public func changeValue(to newValue: String) {
        self.text = newValue
    }
    
}
