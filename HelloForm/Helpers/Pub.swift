import Foundation

@propertyWrapper
public class Pub<Value> {
    public var projectedValue: Pub { self }
    public var wrappedValue: Value { didSet { listener?(wrappedValue) } }
    
    private var listener: ((Value) -> Void)?
    
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
}

extension Pub {
    
    public func bind(_ closure: @escaping (Value) -> Void) {
        closure(wrappedValue)
        listener = closure
    }
    
}
