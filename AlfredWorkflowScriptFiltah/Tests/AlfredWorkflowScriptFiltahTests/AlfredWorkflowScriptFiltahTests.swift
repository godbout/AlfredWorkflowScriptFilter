import XCTest
@testable import AlfredWorkflowScriptFiltah

final class AlfredWorkflowScriptFiltahTests: XCTestCase {
    func test_that_the_output_may_contain_zero_item() {
        let output = ["items": []]
        let string = String(data: try! JSONSerialization.data(withJSONObject: output, options: []), encoding: String.Encoding.utf8)

        XCTAssertEqual(
            ScriptFilter.output(),
            string!
        )
    }
}
