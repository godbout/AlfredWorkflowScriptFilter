// TODO: the Mod class should be abstract
//
// can't do abstract classes in Swift. handle this with a Protocol?

class Mod: HasSubtitle, HasIcon, HasVariables, HasValidity, Codable {
    var subtitle: String?
    private var arg: String?
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

    func arg(_ arg: String) -> Mod {
        self.arg = arg

        return self
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
