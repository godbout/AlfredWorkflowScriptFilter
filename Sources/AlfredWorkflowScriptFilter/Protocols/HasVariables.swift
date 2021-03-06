protocol HasVariables: AnyObject {
    var variables: [String: String]? { get set }

    // TODO: check if adding the below functions in
    // the protocol makes sense. maybe only in extension
    // is better?
    func variables(_ variables: Variable...) -> Self
    func variable(_ variable: Variable) -> Self
}

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
