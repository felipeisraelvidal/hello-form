import UIKit

public protocol TextFieldModifier {
    associatedtype RowType: Row
    
    func font(_ font: UIFont) -> RowType
    func textColor(_ color: UIColor) -> RowType
    func textAlignment(_ alignment: NSTextAlignment) -> RowType
    func textFieldStyle(_ style: UITextField.BorderStyle) -> RowType
    func returnKeyType(_ type: UIReturnKeyType) -> RowType
    func autocapitalizationType(_ type: UITextAutocapitalizationType) -> RowType
    func autocorrectionType(_ type: UITextAutocorrectionType) -> RowType
    func clearButtonMode(_ mode: UITextField.ViewMode) -> RowType
    func onSubmit(_ action: @escaping ((String) -> Void)) -> RowType
}
