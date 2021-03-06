import Foundation

final class ScriptFilter {
    static let shared = ScriptFilter()

    private var rerun: Double?
    private var variables: [String: String]?
    private var items: [Item] = []

    private init() {}

    @discardableResult
    static func rerun(secondsToWait seconds: Double) -> ScriptFilter.Type {
        if seconds >= 0.1, seconds <= 5.0 {
            shared.rerun = seconds
        }

        return self
    }

    // TODO: check if makes sense to use Generic here and have only
    // one add method
    @discardableResult
    static func add(_ variables: Variable...) -> ScriptFilter.Type {
        for variable in variables {
            shared.variables = shared.variables ?? [:]
            shared.variables?[variable.name ?? ""] = variable.value
        }

        return self
    }

    @discardableResult
    static func add(_ items: Item...) -> ScriptFilter.Type {
        for item in items {
            shared.items.append(item)
        }

        return self
    }

    static func output() -> String {
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
