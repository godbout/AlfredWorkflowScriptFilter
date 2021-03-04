@testable import AlfredWorkflowScriptFilter
import XCTest

class FluentAPITests: XCTestCase {
    func test_that_there_is_one_for_Icons() {
        let icon = Icon(path: "~/")
            .type(.fileicon)
            .path("i'm on a new path")

        let expectedOutput = """
        {
            "path": "i'm on a new path",
            "type": "fileicon"
        }
        """

        XCTAssertEqual(
            icon,
            try JSONHelper().iconObject(from: expectedOutput)
        )
    }
}
