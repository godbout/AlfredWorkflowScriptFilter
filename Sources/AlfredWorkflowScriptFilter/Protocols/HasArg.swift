protocol HasArg: AnyObject {
    var arg: String? { get set }
}

extension HasArg {
    @discardableResult
    func arg(_ arg: String) -> Self {
        self.arg = arg

        return self
    }
}
