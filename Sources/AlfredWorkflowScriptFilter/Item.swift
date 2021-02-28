import Foundation

enum ItemType: String, Codable {
    case `default`
    case file
    case fileSkipcheck
}

final class Item {
    private var title: String
    private var subtitle: String?
    private var arg: String?
    private var autocomplete: String?
    private var uid: String?
    private var match: String?
    private var quicklookurl: String?
    private var type: String?

    init(title: String) {
        self.title = title
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

    func quicklookurl(_ quicklookurl: String) -> Item {
        self.quicklookurl = quicklookurl

        return self
    }

    func type(_ type: ItemType) -> Item {
        switch type {
        case .default:
            self.type = "default"
        case .file:
            self.type = "file"
        case .fileSkipcheck:
            self.type = "file:skipcheck"
        }

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
            && lhs.quicklookurl == rhs.quicklookurl
            && lhs.type == rhs.type
    }
}
