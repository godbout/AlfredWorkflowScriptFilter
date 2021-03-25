import Foundation

public enum ItemFilteringProperty {
    case title
    case subtitle
}

public enum ItemSortingProperty {
    case title
    case subtitle
    case match
}

public enum ItemSortingOrder {
    case ascendingly
    case descendingly
}

public final class ScriptFilter: HasVariables {
    static let shared = ScriptFilter()

    private var rerun: Double?
    public var variables: [String: String]?
    private var items: [Item] = []

    private init() {}

    @discardableResult
    public static func rerun(secondsToWait seconds: Double) -> ScriptFilter.Type {
        if seconds >= 0.1, seconds <= 5.0 {
            shared.rerun = seconds
        }

        return self
    }

    @discardableResult
    static func variables(_ variables: Variable...) -> ScriptFilter.Type {
        for variable in variables {
            add(variable)
        }

        return self
    }

    @discardableResult
    public static func variable(_ variable: Variable) -> ScriptFilter.Type {
        add(variable)
    }

    @discardableResult
    static func items(_ items: Item...) -> ScriptFilter.Type {
        for item in items {
            add(item)
        }

        return self
    }

    @discardableResult
    static func item(_ item: Item) -> ScriptFilter.Type {
        add(item)
    }

    @discardableResult
    public static func add(_ variables: Variable...) -> ScriptFilter.Type {
        for variable in variables {
            shared.variable(variable)
        }

        return self
    }

    @discardableResult
    public static func add(_ items: Item...) -> ScriptFilter.Type {
        for item in items {
            shared.items.append(item)
        }

        return self
    }

    @discardableResult
    public static func filterItems(by property: ItemFilteringProperty = .title, containing term: String) -> ScriptFilter.Type {
        if !term.isEmpty {
            shared.items = shared.items.filter { items in
                switch property {
                case .title:
                    return items.title.localizedCaseInsensitiveContains(term)
                case .subtitle:
                    return items.subtitle?.localizedCaseInsensitiveContains(term) ?? false
                }
            }
        }

        return self
    }

    public static func sortItems(by property: ItemSortingProperty = .title, _ order: ItemSortingOrder = .ascendingly) {
        shared.items.sort { firstItem, secondItem in
            switch property {
            case .title:
                if order == .descendingly {
                    return firstItem.title.lowercased() > secondItem.title.lowercased()
                }

                return firstItem.title.lowercased() < secondItem.title.lowercased()
            case .subtitle:
                if let firstSubtitle = firstItem.subtitle, let secondSubtitle = secondItem.subtitle {
                    if order == .descendingly {
                        return firstSubtitle.lowercased() > secondSubtitle.lowercased()
                    }

                    return firstSubtitle.lowercased() < secondSubtitle.lowercased()
                }

                return false
            case .match:
                if let firstMatch = firstItem.match, let secondMatch = secondItem.match {
                    if order == .descendingly {
                        return firstMatch.lowercased() > secondMatch.lowercased()
                    }

                    return firstMatch.lowercased() < secondMatch.lowercased()
                }

                return false
            }
        }
    }

    public static func output() -> String {
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(ScriptFilter.shared) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        }

        return #"{"items":[]}"#
    }

    internal static func reset() {
        shared.rerun = nil
        shared.variables = nil
        shared.items = []
    }
}

extension ScriptFilter: Codable {}

extension ScriptFilter: Equatable {
    public static func == (lhs: ScriptFilter, rhs: ScriptFilter) -> Bool {
        lhs.rerun == rhs.rerun
            && lhs.variables == rhs.variables
            && lhs.items == rhs.items
    }
}
