protocol HasVariables: AnyObject {
    var variables: [String: String]? { get set }
}

// TODO: make protocol extension methods final. Swift?
extension HasVariables {
    @discardableResult
    func variables(_ variables: Variable...) -> Self {
        for variable in variables {
            _ = self.variable(variable)
        }

        return self
    }

    @discardableResult
    func variable(_ variable: Variable) -> Self {
        if variables == nil {
            variables = [:]
        }

        variables?[variable.name ?? ""] = variable.value

        return self
    }
}
