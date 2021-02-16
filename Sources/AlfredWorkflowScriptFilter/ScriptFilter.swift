import Foundation

class ScriptFilter {
    static let shared = ScriptFilter()

    private var rerun: Double?
    private var variables: [String: String]?
    private var items: [Item]?

    private init() {}

    func rerun(secondsToWait seconds: Double) -> ScriptFilter {
        if seconds >= 0.1 && seconds <= 5.0 {
            rerun = seconds
        }

        return self
    }

    @discardableResult
    func add(_ variable: Variable) -> ScriptFilter {
        if variables == nil {
            variables = [:]
        }

        variables![variable.name ?? ""] = variable.value

        return self
    }

    @discardableResult
    func add(_ item: Item) -> ScriptFilter {
        items = (items ?? []) + [item]

        return self
    }

    func output() -> String {
        items = []

        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(ScriptFilter.shared) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        }

        return #"{"items":[]}"#
    }

    internal func reset() {
        rerun = nil
        variables = nil
        items = []
    }
}

extension ScriptFilter: Encodable {
}
