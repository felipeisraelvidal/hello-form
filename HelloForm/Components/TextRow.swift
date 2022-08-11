import UIKit

public final class TextRow: Row, TextRowModifier {
    private(set) var text: Either<String, Observable<String>>
    
    private(set) var _font: UIFont = .preferredFont(forTextStyle: .body)
    private(set) var _textColor: UIColor = UIColor.SystemColor.label
    private(set) var _textAlignment: NSTextAlignment = .natural
    
    public init(
        _ text: Either<String, Observable<String>>,
        image: UIImage? = nil
    ) {
        self.text = text
        
        super.init(image: image)
    }
    
    // MARK: - Modifiers
    
    @discardableResult
    public func font(_ font: UIFont) -> TextRow {
        self._font = font
        return self
    }
    
    @discardableResult
    public func textColor(_ color: UIColor) -> TextRow {
        self._textColor = color
        return self
    }
    
    @discardableResult
    public func textAlignment(_ alignment: NSTextAlignment) -> TextRow {
        self._textAlignment = alignment
        return self
    }
    
}
