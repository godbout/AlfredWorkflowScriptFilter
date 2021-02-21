@testable import AlfredWorkflowScriptFilter
import Foundation

struct JSONHelper {
    func iconObject(from json: String) throws -> Icon? {
        try object(ofType: Icon.self, from: json)
    }

    func scriptFilterObject(from json: String) throws -> ScriptFilter? {
        try object(ofType: ScriptFilter.self, from: json)
    }

    private func object<Object: Codable>(ofType: Object.Type, from json: String) throws -> Object? {
        try JSONDecoder().decode(Object.self, from: json.data(using: .utf8) ?? Data())
    }
}
