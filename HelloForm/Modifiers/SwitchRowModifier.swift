import UIKit

public protocol SwitchRowModifier {
    associatedtype RowType: Row
    
    func font(_ font: UIFont) -> RowType
    func textColor(_ color: UIColor) -> RowType
}
