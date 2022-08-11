import UIKit

public protocol StepperRowModifier {
    associatedtype RowType: Row
    
    func font(_ font: UIFont) -> RowType
    func textColor(_ color: UIColor) -> RowType
}
