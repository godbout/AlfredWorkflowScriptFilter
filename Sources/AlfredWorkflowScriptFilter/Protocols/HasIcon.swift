protocol HasIcon: AnyObject {
    var icon: Icon? { get set }

    func icon(_ icon: Icon) -> Self
}

extension HasIcon {
    // TODO: is there any way to make protocol extension methods final?
    @discardableResult
    func icon(_ icon: Icon) -> Self {
        self.icon = icon

        return self
    }
}
