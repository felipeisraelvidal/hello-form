import UIKit

@resultBuilder
public struct CustomRowBuilder {
    public static func buildBlock(_ component: UIView) -> UIView {
        component
    }
}

public final class CustomRow: Row {
    
    public var content: UIView
    
    public init(
        image: UIImage? = nil,
        @CustomRowBuilder _ content: () -> UIView
    ) {
        self.content = content()
        
        super.init(image: image)
    }
    
}
