import AlfredWorkflowScriptFilter
import XCTest

final class ScriptFilterNotBasicLOLTests: XCTestCase {
    func test_that_it_may_contain_all_the_available_properties_up_to_Alfred_3_5() throws {
        ScriptFilter.add(
            Item(title: "i am the title now")
                .uid("U I D")
                .subtitle("sub title")
                .arg("☠️")
                .icon(
                    Icon(path: "C://MikeRoweSoft")
                )
                .valid()
                .match("45 — 0")
                .autocomplete("tab key")
                .mods(
                    Ctrl()
                        .arg("control arg")
                        .subtitle("control sub")
                        .valid(true)
                )
                .text("text copy", for: .copy)
                .text("text largetype", for: .largetype)
                .quicklookurl("peep")
        )

        ScriptFilter.variable(
            Variable(name: "variator", value: "malossi")
        )

        ScriptFilter.variable(
            Variable(name: "motorcycle", value: "Peugeot 103 SP")
        )

        ScriptFilter.rerun(secondsToWait: 3.9)

        let anotherItem = Item(title: "another or an other?")
            .icon(
                Icon(path: "i wanna cry", type: .fileicon)
            )
            .mods(
                Shift().subtitle("shift subtitle")
            )
        anotherItem.mods(
            Fn()
                .arg("fn arg")
                .valid()
        )

        let thirdItem = Item(title: "3rd ww")
            .variables(Variable(name: "country", value: "France LOL"))
        thirdItem.variables(Variable(name: "language", value: "complaints"))
            .mods(Alt()
                .icon(Icon(path: "alt icon path yes", type: .fileicon))
                .variable(Variable(name: "sport", value: "climbing"))
                .variable(Variable(name: "type", value: "sport (climbing)"))
            )

        ScriptFilter.item(anotherItem)
        ScriptFilter.item(thirdItem)

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "rerun": 3.9,
            "variables": {
                "variator": "malossi",
                "motorcycle": "Peugeot 103 SP"
            },
            "items": [
                {
                    "uid": "U I D",
                    "title": "i am the title now",
                    "subtitle": "sub title",
                    "arg": "☠️",
                    "icon": {
                        "path": "C://MikeRoweSoft"
                    },
                    "valid": true,
                    "match": "45 — 0",
                    "autocomplete": "tab key",
                    "mods": {
                        "ctrl": {
                            "arg": "control arg",
                            "subtitle": "control sub",
                            "valid": true
                        }
                    },
                    "text": {
                        "copy": "text copy",
                        "largetype": "text largetype"
                    },
                    "quicklookurl": "peep"
                },
                {
                    "title": "another or an other?",
                    "icon": {
                        "path": "i wanna cry",
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
                    "title": "3rd ww",
                    "variables": {
                        "country": "France LOL",
                        "language": "complaints"
                    },
                    "mods": {
                        "alt": {
                            "icon": {
                                "path": "alt icon path yes",
                                "type": "fileicon"
                            },
                            "variables": {
                                "sport": "climbing",
                                "type": "sport (climbing)"
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

    func test_that_what_i_describe_in_the_README_actually_works_dotdotdot() throws {
        ScriptFilter.add(
            Item(title: "titlee")
                .uid("uidd")
                .subtitle("subtitlee")
                .arg("argg")
                .icon(
                    Icon(path: "icon path")
                )
                .valid(true)
                .match("matchh")
                .autocomplete("autocompletee")
                .mod(
                    Ctrl()
                        .arg("ctrl arg")
                        .subtitle("ctrl subtitle")
                        .valid(true)
                )
                .text("copyy", for: .copy)
                .text("largetypee", for: .largetype)
                .quicklookurl("quicklookurll")
        )

        ScriptFilter.add(
            Variable(name: "food", value: "chocolate"),
            Variable(name: "dessert", value: "red beans")
        )

        ScriptFilter.rerun(secondsToWait: 4.5)

        let anotherItem = Item(title: "Another Item in the Wall")
            .icon(
                Icon(path: "icon pathh", type: .fileicon)
            )
            .mods(
                Shift()
                    .subtitle("shift subtitle"),
                Fn()
                    .arg("fn arg")
                    .valid(true)
            )

        let thirdItem = Item(title: "3rd")
            .variables(
                Variable(name: "guitar", value: "fender"),
                Variable(name: "amplifier", value: "orange")
            )
            .mod(
                Alt()
                    .icon(
                        Icon(path: "alt icon path", type: .fileicon)
                    )
                    .variables(
                        Variable(name: "grade", value: "colonel"),
                        Variable(name: "drug", value: "power")
                    )
            )

        ScriptFilter.add(
            anotherItem,
            thirdItem
        )

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
                        "largetype": "largetypee"
                    },
                    "quicklookurl": "quicklookurll"
                },
                {
                    "title": "Another Item in the Wall",
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
                    "title": "3rd",
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
                    },
                    "variables": {
                        "guitar": "fender",
                        "amplifier": "orange"
                    }
                }
            ]
        }
        """

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: ScriptFilter.output()),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }
}
