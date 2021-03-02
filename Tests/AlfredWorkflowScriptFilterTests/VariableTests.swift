@testable import AlfredWorkflowScriptFilter
import XCTest

class VariableTests: XCTestCase {
    func test_that_it_may_be_empty() throws {
        let variable = Variable()

        let expectedOutput = """
        {
        }
        """

        XCTAssertEqual(
            variable,
            try JSONHelper().variableObject(from: expectedOutput)
        )
    }

    func test_that_it_may_have_a_name_and_a_value() throws {
        let variable = Variable(name: "fruit", value: "tomato")

        let expectedOutput = """
        {
            "fruit": "tomato"
        }
        """

        XCTAssertEqual(
            variable,
            try JSONHelper().variableObject(from: expectedOutput)
        )
    }
}
