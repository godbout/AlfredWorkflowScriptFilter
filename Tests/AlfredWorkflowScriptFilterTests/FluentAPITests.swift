@testable import AlfredWorkflowScriptFilter
import XCTest

class FluentAPITests: XCTestCase {
    func test_that_there_is_one_for_Icons() throws {
        let icon = Icon(path: "~/")
            .type(.fileicon)
            .path("i'm on a new path")

        let expectedOutput = """
        {
            "path": "i'm on a new path",
            "type": "fileicon"
        }
        """

        XCTAssertEqual(
            icon,
            try JSONHelper().iconObject(from: expectedOutput)
        )
    }

    func test_that_there_is_one_for_Variables() throws {
        let variable = Variable()
            .name("color")
            .value("blue")
            .name("mood")

        let expectedOutput = """
        {
            "name": "mood",
            "value": "blue"
        }
        """

        XCTAssertEqual(
            variable,
            try JSONHelper().variableObject(from: expectedOutput)
        )
    }

    func test_that_there_is_one_for_Mods() throws {
        let cmd = Cmd()
            .subtitle("sous-titre")
            .arg("is arg a fight?")
            .valid(.true)
            .icon(Icon(path: "c://mf"))
            .variables(Variable(name: "food", value: "chicken feet"))

        let expectedOutput = """
        {
            "subtitle": "sous-titre",
            "arg": "is arg a fight?",
            "valid": true,
            "icon": {
                "path": "c://mf"
            },
            "variables": {
                "food": "chicken feet"
            }
        }
        """

        XCTAssertEqual(
            cmd,
            try JSONHelper().modObject(from: expectedOutput)
        )
    }

    func test_that_there_is_one_for_Items() throws {
        let item = Item(title: "idem")
            .arg("argggghhhhh")
            .autocomplete("complete auto")
            .icon(Icon(path: "bath", type: .none))
            .match("tennis?")
            .mods(Cmd().valid(.false))
            .quicklookurl("pervert")
            .subtitle("i'm fluent")
            .text("XXL", for: .largetype)
            .uid("you i d...")
            .valid(.false)
            .variables(Variable(name: "country", value: "macau"))

        let expectedOutput = """
        {
            "title": "idem",
            "arg": "argggghhhhh",
            "autocomplete": "complete auto",
            "icon": {
                "path": "bath"
            },
            "match": "tennis?",
            "mods": {
                "cmd": {}
            },
            "quicklookurl": "pervert",
            "subtitle": "i'm fluent",
            "text": {
                "largetype": "XXL"
            },
            "uid": "you i d...",
            "valid": false,
            "variables": {
                "country": "macau"
            }
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }
}
