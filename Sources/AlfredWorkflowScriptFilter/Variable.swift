struct Variable {
    var name: String?
    var value: String?

    static func create(name: String? = nil, value: String? = nil) -> Variable {
        Variable(name: name, value: value)
    }
}
