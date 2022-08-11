import UIKit

public extension UIColor {
    
    struct SystemColor {
        
        static public var label: UIColor {
            if #available(iOS 13.0, *) {
                return .label
            } else {
                return .black
            }
        }
        
        static public var secondaryLabel: UIColor {
            if #available(iOS 13.0, *) {
                return .secondaryLabel
            } else {
                return .gray
            }
        }
        
    }
    
}
