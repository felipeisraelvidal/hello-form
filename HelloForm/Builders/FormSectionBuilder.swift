import Foundation

@resultBuilder
public struct FormSectionBuilder {
    public static func buildBlock(_ rows: FormRowBase...) -> [FormRowBase] {
        rows
    }
    
    public static func buildBlock(_ components: [FormRowBase]...) -> [FormRowBase] {
        components.flatMap { $0 }
    }
    
    public static func buildEither(first component: [FormRowBase]) -> [FormRowBase] {
        component
    }
    
    public static func buildEither(second component: [FormRowBase]) -> [FormRowBase] {
        component
    }
    
    public static func buildOptional(_ component: [FormRowBase]?) -> [FormRowBase] {
        component ?? []
    }
    
    public static func buildExpression(_ expression: FormRowBase) -> [FormRowBase] {
        [expression]
    }
    
    public static func buildExpression(_ expression: [FormRowBase]) -> [FormRowBase] {
        expression
    }
    
    public static func buildArray(_ components: [[FormRowBase]]) -> [FormRowBase] {
        components.flatMap { $0 }
    }
}
