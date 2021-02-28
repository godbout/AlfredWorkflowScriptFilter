@testable import AlfredWorkflowScriptFilter
import XCTest

class ItemTests: XCTestCase {
    func test_that_it_may_contain_only_a_title() throws {
        let item = Item(title: "some title")
        let expectedOutput = """
        {
            "title": "some title"
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_a_subtitle() throws {
        let item = Item(title: "Sir")
            .subtitle("the subtitle")

        let expectedOutput = """
        {
            "title": "Sir",
            "subtitle": "the subtitle"
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_an_arg() throws {
        let item = Item(title: "A Saucerful of Secrets")
            .arg("crazy")

        let expectedOutput = """
        {
            "title": "A Saucerful of Secrets",
            "arg": "crazy"
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_an_autocomplete() throws {
        let item = Item(title: "titlee")
            .autocomplete("autotitlee")

        let expectedOutput = """
        {
            "title": "titlee",
            "autocomplete": "autotitlee"
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_a_uid() throws {
        let item = Item(title: "can't think of anything")
            .uid("cantthinkofanything")

        let expectedOutput = """
        {
            "title": "can't think of anything",
            "uid": "cantthinkofanything"
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_a_match() throws {
        let item = Item(title: "supermarché")
            .match("supermarche")

        let expectedOutput = """
        {
            "title": "supermarché",
            "match": "supermarche",
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }
}
