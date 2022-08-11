import Foundation

public enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

public extension Either {
    func leftMap<NewLeft>(_ transform: (Left) -> NewLeft) -> Either<NewLeft, Right> {
        switch self {
        case .left(let value):
            return .left(transform(value))
        case .right(let value):
            return .right(value)
        }
    }
    
    func rightMap<NewRight>(_ transform: (Right) -> NewRight) -> Either<Left, NewRight> {
        switch self {
        case .left(let value):
            return .left(value)
        case .right(let value):
            return .right(transform(value))
        }
    }
}

public extension Either {
    func leftApply<NewLeft>(_ transform: Either<(Left) -> NewLeft, Right>) -> Either<NewLeft, Right> {
        switch transform {
        case .left(let transform):
            return leftMap(transform)
        case .right(let value):
            return .right(value)
        }
    }
    
    func rightApply<NewRight>(_ transform: Either<Left, (Right) -> NewRight>) -> Either<Left, NewRight> {
        switch transform {
        case .left(let value):
            return .left(value)
        case .right(let transform):
            return rightMap(transform)
        }
    }
}

public extension Either {
    func leftFlatMap<NewLeft>(_ transform: (Left) -> Either<NewLeft, Right>) -> Either<NewLeft, Right> {
        switch self {
        case .left(let value):
            return transform(value)
        case .right(let value):
            return .right(value)
        }
    }
    
    func rightFlatMap<NewRight>(_ transform: (Right) -> Either<Left, NewRight>) -> Either<Left, NewRight> {
        switch self {
        case .left(let value):
            return .left(value)
        case .right(let value):
            return transform(value)
        }
    }
}
