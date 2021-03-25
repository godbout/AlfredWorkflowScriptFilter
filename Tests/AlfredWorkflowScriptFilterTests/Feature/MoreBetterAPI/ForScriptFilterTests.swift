import AlfredWorkflowScriptFilter
import XCTest

class MoreBetterAPIForScriptFilterTests: XCTestCase {
    func test_that_there_is_a_MoreBetterAPI_to_add_multiple_variables_in_one_shot() throws {
        ScriptFilter.variables(
            Variable(name: "firstname", value: "Guillaume"),
            Variable(name: "lastname", value: "Leclerc")
        )

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "variables": {
                "firstname": "Guillaume",
                "lastname": "Leclerc"
            },
            "items": []
        }
        """

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: output),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_there_is_a_MoreBetterAPI_to_add_multiple_items_in_one_shot() throws {
        ScriptFilter.items(
            Item(title: "1st item"),
            Item(title: "2nd item")
        )

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "items": [
                {
                    "title": "1st item"
                },
                {
                    "title": "2nd item"
                }
            ]
        }
        """

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: output),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_there_is_a_MoreBetterAPI_to_add_multiple_elements_in_one_shot() throws {
        ScriptFilter.add(
            Item(title: "another first item"),
            Item(title: "an other second item")
        )

        ScriptFilter.add(
            Variable(name: "language", value: "xml"),
            Variable(name: "job", value: "xml designer")
        )

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "variables": {
                "language": "xml",
                "job": "xml designer"
            },
            "items": [
                {
                    "title": "another first item"
                },
                {
                    "title": "an other second item"
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
