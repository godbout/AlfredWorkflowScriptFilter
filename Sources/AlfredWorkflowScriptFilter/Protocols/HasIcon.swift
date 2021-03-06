protocol HasIcon: AnyObject {
    var icon: Icon? { get set }
}

extension HasIcon {
    @discardableResult
    func icon(_ icon: Icon) -> Self {
        self.icon = icon

        return self
    }
}
