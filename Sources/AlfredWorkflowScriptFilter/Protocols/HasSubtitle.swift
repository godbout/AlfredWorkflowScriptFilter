public protocol HasSubtitle: AnyObject {
    var subtitle: String? { get set }
}

public extension HasSubtitle {
    @discardableResult
    func subtitle(_ subtitle: String) -> Self {
        self.subtitle = subtitle

        return self
    }
}
