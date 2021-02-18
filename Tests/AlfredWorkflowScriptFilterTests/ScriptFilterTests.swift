@testable import AlfredWorkflowScriptFilter
import XCTest

final class ScriptFilterTests: XCTestCase {
    override func tearDown() {
        ScriptFilter.reset()

        super.tearDown()
    }

    func test_that_it_may_contain_nothing() {
        let output = ScriptFilter.output()
        let expectedOutput = #"{"items":[]}"#

        XCTAssertEqual(
            output,
            expectedOutput
        )
    }

    func test_that_it_may_contain_a_rerun() {
        XCTAssertEqual(
            ScriptFilter.rerun(secondsToWait: 0.0).output(),
            #"{"items":[]}"#
        )

        XCTAssertEqual(
            ScriptFilter.rerun(secondsToWait: 5.1).output(),
            #"{"items":[]}"#
        )

        let output = ScriptFilter.rerun(secondsToWait: 1.3).output()
        let expectedOutput = """
        {
            "rerun": 1.3,
            "items": []
        }
        """

        XCTAssertEqual(
            try JSONSerialization.jsonObject(with: Data(output.utf8), options: []) as! NSDictionary,
            try JSONSerialization.jsonObject(with: Data(expectedOutput.utf8), options: []) as! NSDictionary
        )
    }

    func test_that_it_may_contain_one_variable() {
        let variable = Variable.create(name: "fruit", value: "tomato")

        let output = ScriptFilter.add(variable).output()
        let expectedOutput = """
        {
            "variables": {
                "fruit": "tomato"
            },
            "items": []
        }
        """

        XCTAssertEqual(
            try JSONSerialization.jsonObject(with: Data(output.utf8), options: []) as! NSDictionary,
            try JSONSerialization.jsonObject(with: Data(expectedOutput.utf8), options: []) as! NSDictionary
        )
    }

    func test_that_it_may_contain_several_variables() {
        let firstVariable = Variable.create(name: "fruit", value: "cucumber")
        let secondVariable = Variable.create(name: "vegetable", value: "rhubarb")

        ScriptFilter.add(firstVariable)
        ScriptFilter.add(secondVariable)

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "variables": {
                "fruit": "cucumber",
                "vegetable": "rhubarb"
            },
            "items": []
        }
        """

        XCTAssertEqual(
            try JSONSerialization.jsonObject(with: Data(output.utf8), options: []) as! NSDictionary,
            try JSONSerialization.jsonObject(with: Data(expectedOutput.utf8), options: []) as! NSDictionary
        )
    }

    func test_that_adding_an_empty_variable_results_in_an_empty_JSON_variable_object() {
        let variable = Variable.create()

        ScriptFilter.add(variable)

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "variables": {},
            "items": []
        }
        """

        XCTAssertEqual(
            try JSONSerialization.jsonObject(with: Data(output.utf8), options: []) as! NSDictionary,
            try JSONSerialization.jsonObject(with: Data(expectedOutput.utf8), options: []) as! NSDictionary
        )
    }
}
