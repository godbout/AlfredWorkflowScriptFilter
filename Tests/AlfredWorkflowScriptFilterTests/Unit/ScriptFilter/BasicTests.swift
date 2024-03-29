import AlfredWorkflowScriptFilter
import XCTest

final class ScriptFilterBasicTests: XCTestCase {
    func test_that_it_may_contain_nothing() {
        XCTAssertEqual(
            ScriptFilter.output(),
            #"{"items":[]}"#
        )
    }

    func test_that_it_may_be_rerun() throws {
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
            try JSONHelper().scriptFilterObject(from: output),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_one_variable() throws {
        let variable = Variable(name: "fruit", value: "tomato")

        let output = ScriptFilter.variable(variable).output()
        let expectedOutput = """
        {
            "variables": {
                "fruit": "tomato"
            },
            "items": []
        }
        """

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: output),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_multiple_variables() throws {
        let firstVariable = Variable(name: "fruit", value: "cucumber")
        let secondVariable = Variable(name: "vegetable", value: "rhubarb")

        ScriptFilter.variable(firstVariable)
        ScriptFilter.variable(secondVariable)

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
            try JSONHelper().scriptFilterObject(from: output),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_adding_an_empty_variable_results_in_an_empty_JSON_variable_object() throws {
        let variable = Variable()

        ScriptFilter.variable(variable)

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "variables": {},
            "items": []
        }
        """

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: output),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_one_item() throws {
        let item = Item(title: "a nice title")

        ScriptFilter.item(item)

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "items": [
                {
                    "title": "a nice title",
                }
            ]
        }
        """

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: output),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_multiple_items() throws {
        let firstItem = Item(title: "good title")
        let secondItem = Item(title: "bad title")

        ScriptFilter.item(firstItem)
        ScriptFilter.item(secondItem)

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "items": [
                {
                    "title": "good title",
                },
                {
                    "title": "bad title",
                }
            ]
        }
        """

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: output),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }
}
