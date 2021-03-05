import Foundation

enum ItemTextType {
    case copy
    case largetype
}

enum ItemValidity: String, Codable {
    case `true`
    case `false`
}

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
    private var valid: Bool?
    private var icon: Icon?
    private var text: [String: String]?
    private var variables: [String: String]?
    private var mods: [String: Mod]?

    init(title: String) {
        self.title = title
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

    @discardableResult
    func type(_ type: ItemType) -> Item {
        switch type {
        case .file:
            self.type = "file"
        case .fileSkipcheck:
            self.type = "file:skipcheck"
        default:
            self.type = "default"
        }

        return self
    }

    func valid(_ validity: ItemValidity) -> Item {
        switch validity {
        case .false:
            valid = false
        default:
            valid = true
        }

        return self
    }

    // TODO: refactor
    //
    // same as adding icon in Mod. in PHP we would use a trait.
    // how to do the same in Swift?
    @discardableResult
    func icon(_ icon: Icon) -> Item {
        self.icon = icon

        return self
    }

    @discardableResult
    func text(_ text: String, for: ItemTextType) -> Item {
        if self.text == nil {
            self.text = [:]
        }

        switch `for` {
        case .copy:
            self.text?["copy"] = text
        case .largetype:
            self.text?["largetype"] = text
        }

        return self
    }

    // TODO: refactor
    //
    // same as adding variables in Mod. in PHP we would use a trait.
    // how to do the same in Swift?
    @discardableResult
    func variables(_ variable: Variable) -> Item {
        self.variable(variable)
    }

    func variable(_ variable: Variable) -> Item {
        if variables == nil {
            variables = [:]
        }

        variables?[variable.name ?? ""] = variable.value

        return self
    }

    @discardableResult
    func mods(_ mod: Mod) -> Item {
        self.mod(mod)
    }

    func mod(_ mod: Mod) -> Item {
        mods = mods ?? [:]

        // TODO: ugly as shit. this needs to be refactored
        //
        // should take instead the name of the struct and lowercase
        // it. easy in PHP. but i don't know how to Swift.
        switch mod {
        case is Cmd:
            mods?["cmd"] = mod
        case is Alt:
            mods?["alt"] = mod
        case is Ctrl:
            mods?["ctrl"] = mod
        case is Fn:
            mods?["fn"] = mod
        case is Shift:
            mods?["shift"] = mod
        default:
            break
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
            && lhs.valid == rhs.valid
            && lhs.icon == rhs.icon
            && lhs.text == rhs.text
            && lhs.variables == rhs.variables
            && lhs.mods == rhs.mods
    }
}
