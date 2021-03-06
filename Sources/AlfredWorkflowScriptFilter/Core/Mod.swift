// TODO: make the Mod class abstract. Swift?
class Mod: HasSubtitle, HasArg, HasIcon, HasVariables, HasValidity, Codable {
    var subtitle: String?
    var arg: String?
    var valid: Bool?
    var icon: Icon?
    var variables: [String: String]?

    init(subtitle: String? = nil, arg: String? = nil, valid: HasValidityType? = nil, icon: Icon? = nil, variables: Variable? = nil) {
        self.subtitle = subtitle
        self.arg = arg

        switch valid {
        case .true:
            self.valid = true
        case .false:
            self.valid = false
        default:
            self.valid = nil
        }

        self.icon = icon

        if let variables = variables {
            self.variables(variables)
        } else {
            self.variables = nil
        }
    }
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
