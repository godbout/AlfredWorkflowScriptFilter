import AlfredWorkflowScriptFilter
import XCTest

class MoreBetterAPIForItemTests: XCTestCase {
    func test_that_there_is_a_MoreBetterAPI_to_add_only_one_variable() throws {
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

    func test_that_there_is_a_MoreBetterAPI_to_add_multiple_variables_in_one_shot() throws {
        let item = Item(title: "i t'❤️")
            .variables(
                Variable(name: "fruit", value: "cucumber"),
                Variable(name: "vegetable", value: "rhubarb")
            )

        let expectedOutput = """
        {
            "title": "i t'❤️",
            "variables": {
                "fruit": "cucumber",
                "vegetable": "rhubarb"
            }
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_there_is_a_MoreBetterAPI_to_add_only_one_modifier() throws {
        let item = Item(title: "i t'aime")
            .mod(Alt().subtitle("je te aime"))

        let expectedOutput = """
        {
            "title": "i t'aime",
            "mods": {
                "alt": {
                    "subtitle": "je te aime"
                }
            }
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_there_is_a_MoreBetterAPI_to_add_multiple_modifiers_in_one_shot() throws {
        let item = Item(title: "hello you")
            .mods(Alt(), Cmd(), Ctrl())

        let expectedOutput = """
        {
            "title": "hello you",
            "mods": {
                "alt": {},
                "cmd": {},
                "ctrl": {}
            }
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }
}
