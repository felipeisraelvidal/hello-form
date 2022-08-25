import UIKit

public final class SliderRow: Row {
    @Pub private(set) var value: Float
    private(set) var bounds: ClosedRange<Float>
    private(set) var step: Float.Stride
    
    private(set) var maximumValueLabel: UILabel? = nil
    private(set) var minimumValueLabel: UILabel? = nil
    
    // MARK: - Initializers
    
    public init(
        value: Pub<Float>,
        in bounds: ClosedRange<Float> = 0...1,
        step: Float.Stride = 1,
        image: UIImage? = nil
    ) {
        self._value = value
        self.bounds = bounds
        self.step = step
        
        super.init(image: image)
    }
    
    public init(
        value: Pub<Float>,
        in bounds: ClosedRange<Float> = 0...1,
        step: Float.Stride = 1,
        image: UIImage? = nil,
        @ViewBuilder<UILabel> maximumValueLabel: () -> UILabel,
        @ViewBuilder<UILabel> minimumValueLabel: () -> UILabel
    ) {
        self._value = value
        self.bounds = bounds
        self.step = step
        
        self.maximumValueLabel = maximumValueLabel()
        self.minimumValueLabel = minimumValueLabel()
        
        super.init(image: image)
    }
    
    // MARK: - Public methods
    
    public func changeValue(to newValue: Float) {
        self.value = newValue
    }
}
