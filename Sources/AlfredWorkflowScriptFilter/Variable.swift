struct Variable {
    var name: String?
    var value: String?
}

extension Variable: Codable {}

extension Variable: Equatable {
    static func == (lhs: Variable, rhs: Variable) -> Bool {
        lhs.name == rhs.name
            && lhs.value == rhs.value
    }
}
