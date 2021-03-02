struct Variable {
    private var data: [String: String]?

    init(name: String? = nil, value: String? = nil) {
        data = data ?? [:]
        data?[name ?? ""] = value
    }
}

extension Variable: Codable {}

extension Variable: Equatable {
    static func == (lhs: Variable, rhs: Variable) -> Bool {
        lhs.data == rhs.data
    }
}
