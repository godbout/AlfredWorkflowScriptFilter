// TODO: make the Mod class abstract. Swift?
class Mod: HasSubtitle, HasArg, HasIcon, HasVariables, HasValidity, Codable {
    var subtitle: String?
    var arg: String?
    var valid: Bool?
    var icon: Icon?
    var variables: [String: String]?

    // TODO: check if a subtitle in mandatory in Mod ScriptFilter
    init() {}
}

extension Mod: Equatable {
    static func == (lhs: Mod, rhs: Mod) -> Bool {
        lhs.subtitle == rhs.subtitle
            && lhs.arg == rhs.arg
            && lhs.valid == rhs.valid
            && lhs.icon == rhs.icon
            && lhs.variables == rhs.variables
    }
}

class Ctrl: Mod {}
class Cmd: Mod {}
class Alt: Mod {}
class Fn: Mod {}
class Shift: Mod {}
