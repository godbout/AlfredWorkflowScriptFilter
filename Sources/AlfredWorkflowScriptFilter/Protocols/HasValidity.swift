public enum HasValidityType: String, Codable {
    case `true`
    case `false`
}

public protocol HasValidity: AnyObject {
    var valid: Bool? { get set }
}

public extension HasValidity {
    @discardableResult
    func valid(_ validity: HasValidityType) -> Self {
        switch validity {
        case .false:
            valid = false
        default:
            valid = true
        }

        return self
    }
}
