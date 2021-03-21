@testable import AlfredWorkflowScriptFilter
import XCTest

final class ScriptFilterTests: XCTestCase {
    override func tearDown() {
        ScriptFilter.reset()

        super.tearDown()
    }
}

extension ScriptFilterTests {
    func test_that_it_may_contain_nothing() {
        XCTAssertEqual(
            ScriptFilter.output(),
            #"{"items":[]}"#
        )
    }

    func test_that_it_may_be_rerun() throws {
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
            try JSONHelper().scriptFilterObject(from: output),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_one_variable() throws {
        let variable = Variable(name: "fruit", value: "tomato")

        let output = ScriptFilter.variable(variable).output()
        let expectedOutput = """
        {
            "variables": {
                "fruit": "tomato"
            },
            "items": []
        }
        """

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: output),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_multiple_variables() throws {
        let firstVariable = Variable(name: "fruit", value: "cucumber")
        let secondVariable = Variable(name: "vegetable", value: "rhubarb")

        ScriptFilter.variable(firstVariable)
        ScriptFilter.variable(secondVariable)

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
            try JSONHelper().scriptFilterObject(from: output),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_adding_an_empty_variable_results_in_an_empty_JSON_variable_object() throws {
        let variable = Variable()

        ScriptFilter.variable(variable)

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "variables": {},
            "items": []
        }
        """

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: output),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_one_item() throws {
        let item = Item(title: "a nice title")

        ScriptFilter.item(item)

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "items": [
                {
                    "title": "a nice title",
                }
            ]
        }
        """

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: output),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_multiple_items() throws {
        let firstItem = Item(title: "good title")
        let secondItem = Item(title: "bad title")

        ScriptFilter.item(firstItem)
        ScriptFilter.item(secondItem)

        let output = ScriptFilter.output()
        let expectedOutput = """
        {
            "items": [
                {
                    "title": "good title",
                },
                {
                    "title": "bad title",
                }
            ]
        }
        """

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: output),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }

    func test_that_it_may_contain_all_the_available_properties_up_to_Alfred_3_5() throws {
        ScriptFilter.add(
            Item(title: "titlee")
                .uid("uidd")
                .subtitle("subtitlee")
                .arg("argg")
                .icon(
                    Icon(path: "icon path")
                )
                .valid(.true)
                .match("matchh")
                .autocomplete("autocompletee")
                .mods(
                    Ctrl()
                        .arg("ctrl arg")
                        .subtitle("ctrl subtitle")
                        .valid(.true)
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
                .valid(.true)
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

        ScriptFilter.filterItems(with: "Bon")
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

        ScriptFilter.filterItems(with: "see", in: .subtitle)

        XCTAssertEqual(
            try JSONHelper().scriptFilterObject(from: ScriptFilter.output()),
            try JSONHelper().scriptFilterObject(from: expectedOutput)
        )
    }
}
