import UIKit

public protocol FormRowModifier {
    associatedtype Row: FormRow
    
    func padding(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> Row
    func backgroundColor(_ color: UIColor) -> Row
    func tintColor(_ color: UIColor) -> Row
    func accessoryType(_ accessoryType: UITableViewCell.AccessoryType) -> Row
    func selectionStyle(_ selectionStyle: UITableViewCell.SelectionStyle) -> Row
    func deselectWhenSelect(_ flag: Bool) -> Row
    func addAction(_ action: @escaping () -> Void) -> Row
    func addDetailDisclosureButtonAction(_ action: @escaping () -> Void) -> Row
    func hideSeparators() -> Row
    func reloadRowAnimation(_ animation: UITableView.RowAnimation) -> Row
}
