@testable import AlfredWorkflowScriptFilter
import XCTest

final class ScriptFilterSorteringTests: XCTestCase {
    override func tearDown() {
        ScriptFilter.reset()

        super.tearDown()
    }
}

extension ScriptFilterSorteringTests {
    func test_that_it_can_sort_items_ascendingly_by_title() throws {
        ScriptFilter.add(
            Item(title: "France"),
            Item(title: "Angola"),
            Item(title: "Portugal")
        )

        let expectedOutput = """
        {
            "items": [
                {
                    "title": "Angola"
                },
                {
                    "title": "France"
                },
                {
                    "title": "Portugal"
                }
            ]
        }
        """

        ScriptFilter.sortItems()

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: ScriptFilter.output()),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_can_sort_items_descendingly_by_title() throws {
        ScriptFilter.add(
            Item(title: "France"),
            Item(title: "Angola"),
            Item(title: "Portugal")
        )

        let expectedOutput = """
        {
            "items": [
                {
                    "title": "Portugal"
                },
                {
                    "title": "France"
                },
                {
                    "title": "Angola"
                }
            ]
        }
        """

        ScriptFilter.sortItems(by: .title, .descendingly)

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: ScriptFilter.output()),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_can_sort_items_ascendingly_by_subtitle() throws {
        ScriptFilter.add(
            Item(title: "Megane").subtitle("Renault"),
            Item(title: "206").subtitle("Peugeot"),
            Item(title: "Veyron").subtitle("Bugatti")
        )

        let expectedOutput = """
        {
            "items": [
                {
                    "title": "Veyron",
                    "subtitle": "Bugatti"
                },
                {
                    "title": "206",
                    "subtitle": "Peugeot"
                },
                {
                    "title": "Megane",
                    "subtitle": "Renault"
                }
            ]
        }
        """

        ScriptFilter.sortItems(by: .subtitle, .ascendingly)

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: ScriptFilter.output()),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_can_sort_items_descendingly_by_subtitle() throws {
        ScriptFilter.add(
            Item(title: "Megane").subtitle("Renault"),
            Item(title: "206").subtitle("Peugeot"),
            Item(title: "Veyron").subtitle("Bugatti")
        )

        let expectedOutput = """
        {
            "items": [
                {
                    "title": "Megane",
                    "subtitle": "Renault"
                },
                {
                    "title": "206",
                    "subtitle": "Peugeot"
                },
                {
                    "title": "Veyron",
                    "subtitle": "Bugatti"
                }
            ]
        }
        """

        ScriptFilter.sortItems(by: .subtitle, .descendingly)

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: ScriptFilter.output()),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_sorting_items_is_case_insensitive() throws {
        ScriptFilter.add(
            Item(title: "Sleeplessmind Ltd."),
            Item(title: "glmb.today"),
            Item(title: "sleeplessmind.info"),
            Item(title: "I Was Just Thinking"),
            Item(title: "dailycuckoo.xyz")
        )

        let expectedOutput = """
        {
            "items": [
                {
                    "title": "dailycuckoo.xyz"
                },
                {
                    "title": "glmb.today"
                },
                {
                    "title": "I Was Just Thinking"
                },
                {
                    "title": "Sleeplessmind Ltd."
                },
                {
                    "title": "sleeplessmind.info"
                }
            ]
        }
        """

        ScriptFilter.sortItems()

        print("ScriptFilter output:" + ScriptFilter.output())
        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: ScriptFilter.output()),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }
}
