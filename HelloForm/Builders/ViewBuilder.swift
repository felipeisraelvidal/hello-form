import UIKit

@resultBuilder
public struct ViewBuilder<V: UIView> {
    public static func buildBlock(_ view: V) -> V {
        view
    }
}
