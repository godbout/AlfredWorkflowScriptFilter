protocol HasArg: AnyObject {
    var arg: String? { get set }

    func arg(_ arg: String) -> Self
}

extension HasArg {
    @discardableResult
    func arg(_ arg: String) -> Self {
        self.arg = arg

        return self
    }
}
