@testable import AlfredWorkflowScriptFilter
import XCTest

final class ScriptFilterTests: XCTestCase {
    override func tearDown() {
        ScriptFilter.reset()

        super.tearDown()
    }

    func scriptFilterObject(from json: String) throws -> ScriptFilter? {
        try JSONDecoder().decode(ScriptFilter.self, from: json.data(using: .utf8) ?? Data())
    }
}

extension ScriptFilterTests {
    func test_that_it_may_contain_nothing() {
        XCTAssertEqual(
            ScriptFilter.output(),
            #"{"items":[]}"#
        )
    }

    func test_that_it_may_contain_a_rerun() throws {
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
            try scriptFilterObject(from: output),
            try scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_one_variable() throws {
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
            try scriptFilterObject(from: output),
            try scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_multiple_variables() throws {
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
            try scriptFilterObject(from: output),
            try scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_adding_an_empty_variable_results_in_an_empty_JSON_variable_object() throws {
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
            try scriptFilterObject(from: output),
            try scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_one_item() throws {
        let item = Item.create(title: "a title", subtitle: "a subtitle", icon: Icon())

        ScriptFilter.add(item)

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "items": [
                {
                    "title": "a title",
                    "subtitle": "a subtitle",
                    "icon": {}
                }
            ]
        }
        """

        XCTAssertEqual(
            try scriptFilterObject(from: output),
            try scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_multiple_items() throws {
        let firstItem = Item.create(title: "first title", subtitle: "first subtitle", icon: Icon())
        let secondItem = Item.create(title: "second title", subtitle: "second subtitle", icon: Icon())

        ScriptFilter.add(firstItem)
        ScriptFilter.add(secondItem)

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "items": [
                {
                    "title": "first title",
                    "subtitle": "first subtitle",
                    "icon": {}
                },
                {
                    "title": "second title",
                    "subtitle": "second subtitle",
                    "icon": {}
                }
            ]
        }
        """

        XCTAssertEqual(
            try scriptFilterObject(from: output),
            try scriptFilterObject(from: expectedOutput)
        )
    }
}
