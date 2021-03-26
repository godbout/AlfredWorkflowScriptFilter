import AlfredWorkflowScriptFilter
import XCTest

final class ScriptFilterNotBasicLOLTests: XCTestCase {
    func test_that_it_may_contain_all_the_available_properties_up_to_Alfred_3_5() throws {
        ScriptFilter.add(
            Item(title: "titlee")
                .uid("uidd")
                .subtitle("subtitlee")
                .arg("argg")
                .icon(
                    Icon(path: "icon path")
                )
                .valid()
                .match("matchh")
                .autocomplete("autocompletee")
                .mods(
                    Ctrl()
                        .arg("ctrl arg")
                        .subtitle("ctrl subtitle")
                        .valid(true)
                )
                .text("copyy", for: .copy)
                .text("largetype", for: .largetype)
                .quicklookurl("quicklookurll")
        )

        ScriptFilter.variable(
            Variable(name: "food", value: "chocolate")
        )

        ScriptFilter.variable(
            Variable(name: "dessert", value: "red beans")
        )

        ScriptFilter.rerun(secondsToWait: 4.5)

        let anotherItem = Item(title: "other item in the wall")
            .icon(
                Icon(path: "icon pathh", type: .fileicon)
            )
            .mods(
                Shift().subtitle("shift subtitle")
            )
        anotherItem.mods(
            Fn()
                .arg("fn arg")
                .valid()
        )

        let thirdItem = Item(title: "third itemm")
            .variables(Variable(name: "guitar", value: "fender"))
        thirdItem.variables(Variable(name: "amplifier", value: "orange"))
            .mods(Alt()
                .icon(Icon(path: "alt icon path", type: .fileicon))
                .variable(Variable(name: "grade", value: "colonel"))
                .variable(Variable(name: "drug", value: "power"))
            )

        ScriptFilter.item(anotherItem)
        ScriptFilter.item(thirdItem)

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "rerun": 4.5,
            "variables": {
                "food": "chocolate",
                "dessert": "red beans"
            },
            "items": [
                {
                    "uid": "uidd",
                    "title": "titlee",
                    "subtitle": "subtitlee",
                    "arg": "argg",
                    "icon": {
                        "path": "icon path"
                    },
                    "valid": true,
                    "match": "matchh",
                    "autocomplete": "autocompletee",
                    "mods": {
                        "ctrl": {
                            "arg": "ctrl arg",
                            "subtitle": "ctrl subtitle",
                            "valid": true
                        }
                    },
                    "text": {
                        "copy": "copyy",
                        "largetype": "largetype"
                    },
                    "quicklookurl": "quicklookurll"
                },
                {
                    "title": "other item in the wall",
                    "icon": {
                        "path": "icon pathh",
                        "type": "fileicon"
                    },
                    "mods": {
                        "shift": {
                            "subtitle": "shift subtitle"
                        },
                        "fn": {
                            "arg": "fn arg",
                            "valid": true
                        }
                    }
                },
                {
                    "title": "third itemm",
                    "variables": {
                        "guitar": "fender",
                        "amplifier": "orange"
                    },
                    "mods": {
                        "alt": {
                            "icon": {
                                "path": "alt icon path",
                                "type": "fileicon"
                            },
                            "variables": {
                                "grade": "colonel",
                                "drug": "power"
                            }
                        }
                    }
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
