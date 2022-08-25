import UIKit

/// A view that displays one or more lines of read-only text.
///
/// A text view draws a string in your app's user interface using
/// default font that's appropriate for the current platform. You can
/// choose a different standard font, using the ``TextRow/font(_:)``
/// view modifier.
///
///     TextRow("Hamlet")
///         .font(.preferredFont(forTextStyle: .body))
///
/// ![A text view showing the name "Hamlet" in a title
/// font.](text_row_example.png)
public final class TextRow: Row, TextRowModifier {
    private(set) var text: Either<String, Pub<String>>
    
    private(set) var _font: UIFont = .preferredFont(forTextStyle: .body)
    private(set) var _textColor: UIColor = UIColor.SystemColor.label
    private(set) var _textAlignment: NSTextAlignment = .natural
    
    public init(
        _ text: String,
        image: UIImage? = nil
    ) {
        self.text = .left(text)
        
        super.init(image: image)
    }
    
    public init(
        _ text: Pub<String>,
        image: UIImage? = nil
    ) {
        self.text = .right(text)
        
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
