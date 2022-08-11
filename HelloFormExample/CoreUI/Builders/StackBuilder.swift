import UIKit

@resultBuilder
public struct StackBuilder {
    public static func buildBlock(_ views: UIView...) -> [UIView] {
        views
    }
}
