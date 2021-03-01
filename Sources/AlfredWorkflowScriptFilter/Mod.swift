// TODO: the Mod class should be abstract
//
// can't do abstract classes in Swift. handle this with a Protocol?

class Mod: Codable {
    private var subtitle: String?
    private var arg: String?

    init(subtitle: String? = nil, arg: String? = nil) {
        self.subtitle = subtitle
        self.arg = arg
    }
}

extension Mod: Equatable {
    static func == (lhs: Mod, rhs: Mod) -> Bool {
        lhs.subtitle == rhs.subtitle
            && lhs.arg == rhs.arg
    }
}

class Ctrl: Mod {}
class Cmd: Mod {}
