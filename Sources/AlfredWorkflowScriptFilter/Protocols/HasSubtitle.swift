protocol HasSubtitle: AnyObject {
    var subtitle: String? { get set }
}

extension HasSubtitle {
    @discardableResult
    public func subtitle(_ subtitle: String) -> Self {
        self.subtitle = subtitle

        return self
    }
}
