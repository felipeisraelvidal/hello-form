import UIKit

public protocol TextRowModifier {
    associatedtype RowType: Row
    
    func font(_ font: UIFont) -> RowType
    func textColor(_ color: UIColor) -> RowType
    func textAlignment(_ alignment: NSTextAlignment) -> RowType
}

