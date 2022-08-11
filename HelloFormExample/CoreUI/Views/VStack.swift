import UIKit

public final class VStack: UIStackView {
    
    public init(
        alignment: UIStackView.Alignment = .center,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 0,
        @StackBuilder views: () -> [UIView]
    ) {
        super.init(frame: .zero)
        
        self.axis = .vertical
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        
        translatesAutoresizingMaskIntoConstraints = false
        views().forEach { addArrangedSubview($0) }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
