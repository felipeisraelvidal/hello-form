import UIKit

protocol StackModifier {
    associatedtype Stack: UIStackView
    
    func setAlignment(_ alignment: UIStackView.Alignment) -> Stack
    func setDistribution(_ distribution: UIStackView.Distribution) -> Stack
    func setSpacing(_ spacing: CGFloat) -> Stack
}
