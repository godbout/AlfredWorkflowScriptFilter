@testable import AlfredWorkflowScriptFilter
import XCTest

class FluentAPITests: XCTestCase {
    func test_that_there_is_one_for_Icons() throws {
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

    func test_that_there_is_one_for_Variables() {
        let variable = Variable()
            .name("color")
            .value("blue")
            .name("mood")

        let expectedOutput = """
        {
            "name": "mood",
            "value": "blue"
        }
        """

        XCTAssertEqual(
            variable,
            try JSONHelper().variableObject(from: expectedOutput)
        )
    }
}
