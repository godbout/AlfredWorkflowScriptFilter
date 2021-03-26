@testable import AlfredWorkflowScriptFilter
import XCTest

extension XCTestCase {
    override open func tearDown() {
        ScriptFilter.reset()

        super.tearDown()
    }
}
