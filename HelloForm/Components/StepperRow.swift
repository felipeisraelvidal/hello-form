import UIKit

public final class StepperRow: Row, StepperRowModifier {
    private(set) var title: String
    private(set) var value: Observable<Double>
    private(set) var bounds: ClosedRange<Double>
    private(set) var step: Double.Stride = 1
    
    private(set) var onIncrement: (() -> Void)?
    private(set) var onDecrement: (() -> Void)?
    
    private(set) var _font: UIFont = .preferredFont(forTextStyle: .body)
    private(set) var _textColor: UIColor = .SystemColor.label
    
    // MARK: - Initializers
    
    public init(
        _ title: String,
        value: Observable<Double>,
        in bounds: ClosedRange<Double>,
        step: Double.Stride = 1,
        image: UIImage? = nil,
        onIncrement: (() -> Void)? = nil,
        onDecrement: (() -> Void)? = nil
    ) {
        self.title = title
        self.value = value
        self.bounds = bounds
        self.step = step
        
        self.onIncrement = onIncrement
        self.onDecrement = onDecrement
        
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
    
}
