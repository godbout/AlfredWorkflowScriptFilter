import Foundation

final class ScriptFilter {
    static let shared = ScriptFilter()

    private var rerun: Double?
    private var variables: [String: String]?
    private var items: [Item]?

    private init() {}

    static func rerun(secondsToWait seconds: Double) -> ScriptFilter.Type {
        if seconds >= 0.1, seconds <= 5.0 {
            shared.rerun = seconds
        }

        return self
    }

    @discardableResult
    static func add(_ variable: Variable) -> ScriptFilter.Type {
        if shared.variables == nil {
            shared.variables = [:]
        }

        shared.variables?[variable.name ?? ""] = variable.value

        return self
    }

    @discardableResult
    static func add(_ item: Item) -> ScriptFilter.Type {
        shared.items = (shared.items ?? []) + [item]

        return self
    }

    static func output() -> String {
        shared.items = []

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
    static func == (lhs: ScriptFilter, rhs: ScriptFilter) -> Bool {
        lhs.rerun == rhs.rerun
            && lhs.variables == rhs.variables
            && lhs.items == rhs.items
    }
}
