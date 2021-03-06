enum HasValidityType: String, Codable {
    case `true`
    case `false`
}

protocol HasValidity: AnyObject {
    var valid: Bool? { get set }

    func valid(_ validity: HasValidityType) -> Self
}

extension HasValidity {
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
