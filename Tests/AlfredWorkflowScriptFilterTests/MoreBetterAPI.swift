@testable import AlfredWorkflowScriptFilter
import XCTest

class MoreBetterAPI: XCTestCase {
    func test_that_there_is_a_shorthand_to_add_only_one_variable_to_an_item() throws {
        let item = Item(title: "the title")
            .variable(Variable(name: "breakfast", value: "whisky"))

        let expectedOutput = """
        {
            "title": "the title",
            "variables": {
                "breakfast": "whisky"
            }
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_there_is_a_shorthand_to_add_only_one_variable_to_an_mod() throws {
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
}
