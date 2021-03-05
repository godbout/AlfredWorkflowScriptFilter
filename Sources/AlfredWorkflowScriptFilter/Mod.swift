// TODO: the Mod class should be abstract
//
// can't do abstract classes in Swift. handle this with a Protocol?

class Mod: Codable {
    private var subtitle: String?
    private var arg: String?
    private var valid: Bool?
    private var icon: Icon?
    private var variables: [String: String]?

    init(subtitle: String? = nil, arg: String? = nil, valid: ItemValidity? = nil, icon: Icon? = nil, variables: Variable? = nil) {
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

    func subtitle(_ subtitle: String) -> Mod {
        self.subtitle = subtitle

        return self
    }

    func arg(_ arg: String) -> Mod {
        self.arg = arg

        return self
    }

    func valid(_ validity: ItemValidity) -> Mod {
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
    // same as adding icon in Item. in PHP we would use a trait.
    // how to do the same in Swift?
    @discardableResult
    func icon(_ icon: Icon) -> Mod {
        self.icon = icon

        return self
    }

    // TODO: refactor
    //
    // same as adding variables in Item. in PHP we would use a trait.
    // how to do the same in Swift?
    @discardableResult
    func variables(_ variable: Variable) -> Mod {
        self.variable(variable)
    }

    func variable(_ variable: Variable) -> Mod {
        variables = variables ?? [:]
        variables?[variable.name ?? ""] = variable.value

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
