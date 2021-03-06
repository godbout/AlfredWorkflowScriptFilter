protocol HasSubtitle: AnyObject {
    var subtitle: String? { get set }

    func subtitle(_ subtitle: String) -> Self
}

extension HasSubtitle {
    @discardableResult
    func subtitle(_ subtitle: String) -> Self {
        self.subtitle = subtitle

        return self
    }
}
