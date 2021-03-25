import AlfredWorkflowScriptFilter
import XCTest

final class ScriptFilterFilteringTests: XCTestCase {
    func test_that_it_can_filter_items_by_title() throws {
        ScriptFilter.add(
            Item(title: "Olá"),
            Item(title: "Bonjour"),
            Item(title: "Hello")
        )

        let expectedOutputNotFiltered = """
        {
            "items": [
                {
                    "title": "Olá"
                },
                {
                    "title": "Bonjour"
                },
                {
                    "title": "Hello"
                }
            ]
        }
        """

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: ScriptFilter.output()),
            try JSONHelper().scriptFilterObject(from: expectedOutputNotFiltered)
        )

        ScriptFilter.filterItems(containing: "Bon")
        let expectedOutputFiltered = """
        {
            "items": [
                {
                    "title": "Bonjour"
                }
            ]
        }
        """

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: ScriptFilter.output()),
            try JSONHelper().scriptFilterObject(from: expectedOutputFiltered)
        )
    }

    func test_that_it_can_filter_items_by_subtitle() throws {
        ScriptFilter.add(
            Item(title: "Delete").subtitle("Select to delete timer"),
            Item(title: "Choose").subtitle("Select to choose timer"),
            Item(title: "See").subtitle("Select to see timer"),
            Item(title: "Continue").subtitle("Select to continue timer")
        )

        let expectedOutput = """
        {
            "items": [
                {
                    "title": "See",
                    "subtitle": "Select to see timer"
                }
            ]
        }
        """

        ScriptFilter.filterItems(by: .subtitle, containing: "see")

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: ScriptFilter.output()),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_filtering_by_an_empty_string_does_not_filter_items() throws {
        ScriptFilter.add(
            Item(title: "bananas"),
            Item(title: "apricots"),
            Item(title: "tomatoes")
        )

        let expectedOutput = """
        {
            "items": [
                {
                    "title": "bananas"
                },
                {
                    "title": "apricots"
                },
                {
                    "title": "tomatoes"
                }
            ]
        }
        """

        ScriptFilter.filterItems(containing: "")

        print("output")
        print(ScriptFilter.output())

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: ScriptFilter.output()),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_filtering_items_is_case_insensitive() throws {
        ScriptFilter.add(
            Item(title: "Renault"),
            Item(title: "Peugeot"),
            Item(title: "Citroën")
        )

        let expectedOutput = """
        {
            "items": [
                {
                    "title": "Peugeot"
                }
            ]
        }
        """

        ScriptFilter.filterItems(containing: "peu")

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: ScriptFilter.output()),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }
}
