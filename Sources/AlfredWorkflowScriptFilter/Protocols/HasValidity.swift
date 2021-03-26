public protocol HasValidity: AnyObject {
    var valid: Bool? { get set }
}

public extension HasValidity {
    @discardableResult
    func valid(_ validity: Bool = true) -> Self {
        valid = validity

        return self
    }
}
