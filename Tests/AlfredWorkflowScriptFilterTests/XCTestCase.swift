@testable import AlfredWorkflowScriptFilter
import XCTest

extension XCTestCase {
    open override func tearDown() {
        ScriptFilter.reset()

        super.tearDown()
    }
}
