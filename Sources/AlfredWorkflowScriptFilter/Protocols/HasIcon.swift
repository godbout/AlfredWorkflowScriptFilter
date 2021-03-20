public protocol HasIcon: AnyObject {
    var icon: Icon? { get set }
}

public extension HasIcon {
    @discardableResult
    func icon(_ icon: Icon) -> Self {
        self.icon = icon

        return self
    }
}
