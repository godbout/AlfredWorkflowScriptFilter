import AlfredWorkflowScriptFilter
import XCTest

class MoreBetterAPIForModTests: XCTestCase {
    func test_that_there_is_a_MoreBetterAPI_to_add_only_one_variable() throws {
        let cmd = Cmd().variable(Variable(name: "language", value: "yes"))

        let expectedOutput = """
        {
            "variables": {
                "language": "yes"
            }
        }
        """

        XCTAssertEqual(
            cmd,
            try JSONHelper().modObject(from: expectedOutput)
        )
    }

    func test_that_there_is_a_MoreBetterAPI_to_add_multiple_variables_in_one_shot() throws {
        let ctrl = Ctrl()
            .variables(
                Variable(name: "band", value: "Pink Floyd"),
                Variable(name: "book", value: "Sum")
            )

        let expectedOutput = """
        {
            "variables": {
                "band": "Pink Floyd",
                "book": "Sum"
            }
        }
        """

        XCTAssertEqual(
            ctrl,
            try JSONHelper().modObject(from: expectedOutput)
        )
    }
}
