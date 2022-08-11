import Foundation

public protocol FormSectionConvertible {
    func asFormSection() -> [FormSection]
}

@resultBuilder
public struct FormBuilder {
    public static func buildBlock(_ values: FormSectionConvertible...) -> [FormSection] {
        values.flatMap { $0.asFormSection() }
    }
}

extension FormBuilder {
    public static func buildOptional(_ component: FormSectionConvertible?) -> FormSectionConvertible {
        component ?? []
    }
}

extension FormBuilder {
    public static func buildEither(first component: [FormSection]) -> [FormSection] {
        component
    }
    
    public static func buildEither(second component: [FormSection]) -> [FormSection] {
        component
    }
}

extension FormSection: FormSectionConvertible {
    public func asFormSection() -> [FormSection] { [self] }
}

extension Array: FormSectionConvertible where Element == FormSection {
    public func asFormSection() -> [FormSection] { self }
}
