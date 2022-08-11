import UIKit

public protocol TextDescriptionRowModifier {
    associatedtype RowType: Row
    
    func font(titleLabel: UIFont, descritionLabel: UIFont) -> RowType
    func textColor(titleLabel: UIColor, descriptionLabel: UIColor) -> RowType
}
