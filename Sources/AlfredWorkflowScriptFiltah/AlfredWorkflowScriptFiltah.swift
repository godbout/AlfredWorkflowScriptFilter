class ScriptFilter {
    static let shared = ScriptFilter()

    private init() {}

    static func output() -> String {
        return "{\"items\":[]}"
    }
}
