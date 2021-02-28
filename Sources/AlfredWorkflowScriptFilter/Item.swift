import Foundation

final class Item {
    private var title: String
    private var subtitle: String?
    private var arg: String?
    private var autocomplete: String?
    private var uid: String?
    private var match: String?

    init(title: String) {
        self.title = title
        subtitle = nil
        arg = nil
        autocomplete = nil
        uid = nil
    }

    func title(_ title: String) -> Item {
        self.title = title

        return self
    }

    func subtitle(_ subtitle: String) -> Item {
        self.subtitle = subtitle

        return self
    }

    func arg(_ arg: String) -> Item {
        self.arg = arg

        return self
    }

    func autocomplete(_ autocomplete: String) -> Item {
        self.autocomplete = autocomplete

        return self
    }

    func uid(_ uid: String) -> Item {
        self.uid = uid

        return self
    }

    func match(_ match: String) -> Item {
        self.match = match

        return self
    }
}

extension Item: Codable {}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.title == rhs.title
            && lhs.subtitle == rhs.subtitle
            && lhs.arg == rhs.arg
            && lhs.autocomplete == rhs.autocomplete
            && lhs.uid == rhs.uid
            && lhs.match == rhs.match
    }
}
