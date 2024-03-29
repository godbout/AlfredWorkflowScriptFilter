import AlfredWorkflowScriptFilter
import Foundation

struct JSONHelper {
    func iconObject(from json: String) throws -> Icon? {
        try object(ofType: Icon.self, from: json)
    }

    func scriptFilterObject(from json: String) throws -> ScriptFilter? {
        try object(ofType: ScriptFilter.self, from: json)
    }

    func itemObject(from json: String) throws -> Item? {
        try object(ofType: Item.self, from: json)
    }

    func modObject(from json: String) throws -> Mod? {
        try object(ofType: Mod.self, from: json)
    }

    func variableObject(from json: String) throws -> Variable? {
        try object(ofType: Variable.self, from: json)
    }

    private func object<Object: Codable>(ofType _: Object.Type, from json: String) throws -> Object? {
        try JSONDecoder().decode(Object.self, from: json.data(using: .utf8) ?? Data())
    }
}
