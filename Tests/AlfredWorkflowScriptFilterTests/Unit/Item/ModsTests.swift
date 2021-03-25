import AlfredWorkflowScriptFilter
import XCTest

class ItemModsTests: XCTestCase {
    private var item: Item?

    override func setUp() {
        super.setUp()

        item = Item(title: "wat mod ru using")
    }
}

extension ItemModsTests {
    func test_that_it_may_have_one_modifier() throws {
        item?.mods(
            Ctrl()
                .subtitle("a nice sub")
                .arg("new argument")
                .valid(.false)
        )

        let expectedOutput = """
        {
            "title": "wat mod ru using",
            "mods": {
                "ctrl": {
                    "subtitle": "a nice sub",
                    "arg": "new argument",
                    "valid": false
                }
            }
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_it_may_have_multiple_modifiers() throws {
        item?.mods(
            Shift()
                .arg("argh")
                .valid(.false)
        )
        item?.mods(Ctrl().subtitle("undertitle"))

        let expectedOutput = """
        {
            "title": "wat mod ru using",
            "mods": {
                "shift": {
                    "arg": "argh",
                    "valid": false
                },
                "ctrl": {
                    "subtitle": "undertitle"
                }
            }
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_it_may_have_all_modifiers_together() {
        item?.mods(Shift().arg("shift"))
        item?.mods(Fn().arg("fn"))
        item?.mods(Ctrl().arg("ctrl"))
        item?.mods(Alt().arg("alt"))
        item?.mods(Cmd().arg("cmd"))

        let expectedOutput = """
        {
            "title": "wat mod ru using",
            "mods": {
                "shift": {
                    "arg": "shift"
                },
                "fn": {
                    "arg": "fn"
                },
                "ctrl": {
                    "arg": "ctrl"
                },
                "alt": {
                    "arg": "alt"
                },
                "cmd": {
                    "arg": "cmd"
                }
            }
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }
}
