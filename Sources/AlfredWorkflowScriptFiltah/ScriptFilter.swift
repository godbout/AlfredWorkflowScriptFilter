import Foundation

class ScriptFilter {
    static let shared = ScriptFilter()

    private var rerun: Double?

    private init() {}

    func output() -> String {
        var output: [String: Any] = [:]

        if let rerun = rerun {
            output["rerun"] = rerun
        }

        output["items"] = []

        if let json = try? JSONSerialization.data(withJSONObject: output, options: []) {
            if let jsonString = String(data: json, encoding: String.Encoding.utf8) {
                return jsonString
            }
        }

        return #"{"items": []}"#
    }

    func rerun(secondsToWait seconds: Double) -> ScriptFilter {
        if seconds >= 0.1 && seconds <= 5.0 {
            rerun = seconds
        }

        return self
    }
}