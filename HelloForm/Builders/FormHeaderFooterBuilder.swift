import UIKit

@resultBuilder
public struct FormHeaderFooterBuilder<V: UIView> {
    public static func buildBlock(_ view: V) -> V {
        view
    }
}
