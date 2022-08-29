import UIKit

public final class TextRow: Row, TextRowModifier {
    private(set) var text: Either<Either<String, NSAttributedString>, Either<Pub<String>, Pub<NSAttributedString>>>
    
    private(set) var _font: UIFont = .preferredFont(forTextStyle: .body)
    private(set) var _textColor: UIColor = UIColor.SystemColor.label
    private(set) var _textAlignment: NSTextAlignment = .natural
    
    public init(
        _ text: String,
        image: UIImage? = nil
    ) {
        self.text = .left(.left(text))
        
        super.init(image: image)
    }
    
    public init(
        _ text: Pub<String>,
        image: UIImage? = nil
    ) {
        self.text = .right(.left(text))
        
        super.init(image: image)
    }
    
    public init(
        _ text: NSAttributedString,
        image: UIImage? = nil
    ) {
        self.text = .left(.right(text))
    }
    
    public init(
        _ text: Pub<NSAttributedString>,
        image: UIImage? = nil
    ) {
        self.text = .right(.right(text))
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
