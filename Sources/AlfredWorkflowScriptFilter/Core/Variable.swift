public final class Variable {
    var name: String?
    var value: String?

    public init(name: String? = nil, value: String? = nil) {
        self.name = name
        self.value = value
    }

    @discardableResult
    public func name(_ name: String) -> Variable {
        self.name = name

        return self
    }

    @discardableResult
    public func value(_ value: String) -> Variable {
        self.value = value

        return self
    }
}

extension Variable: Codable {}

extension Variable: Equatable {
    public static func == (lhs: Variable, rhs: Variable) -> Bool {
        lhs.name == rhs.name
            && lhs.value == rhs.value
    }
}
