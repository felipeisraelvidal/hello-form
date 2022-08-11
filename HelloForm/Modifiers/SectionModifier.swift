import UIKit

public protocol FormSectionModifier {
    associatedtype Section: FormSection
    
    func preventDeselectionWhenViewAppear() -> Section
}
