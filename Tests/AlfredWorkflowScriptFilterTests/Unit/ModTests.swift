import AlfredWorkflowScriptFilter
import XCTest

class ModTests: XCTestCase {
    func test_that_it_may_have_a_subtitle() throws {
        let mod = Ctrl()
            .subtitle("eng.srt")

        let expectedOutput = """
        {
            "subtitle": "eng.srt"
        }
        """

        XCTAssertEqual(
            mod,
            try JSONHelper().modObject(from: expectedOutput)
        )
    }

    func test_that_it_may_have_an_arg() throws {
        let mod = Cmd()
            .arg("nice arg, babe.")

        let expectedOutput = """
        {
            "arg": "nice arg, babe."
        }
        """

        XCTAssertEqual(
            mod,
            try JSONHelper().modObject(from: expectedOutput)
        )
    }

    func test_that_it_may_be_valid() throws {
        let mod = Alt()
            .valid(.true)

        let expectedOutput = """
        {
            "valid": true
        }
        """

        XCTAssertEqual(
            mod,
            try JSONHelper().modObject(from: expectedOutput)
        )
    }

    func test_that_it_may_not_be_valid() throws {
        let mod = Fn()
            .valid(.false)

        let expectedOutput = """
        {
            "valid": false
        }
        """

        XCTAssertEqual(
            mod,
            try JSONHelper().modObject(from: expectedOutput)
        )
    }

    func test_that_it_maybe_have_an_icon() throws {
        let mod = Shift()
            .icon(Icon(path: "~/Dev"))

        let expectedOutput = """
        {
            "icon": {
                "path": "~/Dev"
            }
        }
        """

        XCTAssertEqual(
            mod,
            try JSONHelper().modObject(from: expectedOutput)
        )
    }

    func test_that_it_cannot_have_multiple_icons() throws {
        let mod = Shift()
            .icon(Icon(path: "i con"))
        mod.icon(Icon(path: "another").type(.fileicon))

        let expectedOutput = """
        {
            "icon": {
                "path": "another",
                "type": "fileicon"
            }
        }
        """

        XCTAssertEqual(
            mod,
            try JSONHelper().modObject(from: expectedOutput)
        )
    }

    func test_that_it_may_have_an_empty_variables_object() throws {
        let mod = Cmd()
            .variable(Variable())

        let expectedOutput = """
        {
            "variables": {}
        }
        """

        XCTAssertEqual(
            mod,
            try JSONHelper().modObject(from: expectedOutput)
        )
    }

    func test_that_it_may_have_one_variable() throws {
        let mod = Shift()
            .variable(
                Variable(name: "car", value: "Toyota")
            )

        let expectedOutput = """
        {
            "variables": {
                "car": "Toyota"
            }
        }
        """

        XCTAssertEqual(
            mod,
            try JSONHelper().modObject(from: expectedOutput)
        )
    }

    func test_that_it_may_have_multiple_variables() throws {
        let mod = Alt()
        mod.variables(Variable(name: "plane", value: "Airbus"))
        mod.variables(Variable(name: "fruit", value: "apple"))

        let expectedOutput = """
        {
            "variables": {
                "plane": "Airbus",
                "fruit": "apple"
            }
        }
        """

        XCTAssertEqual(
            mod,
            try JSONHelper().modObject(from: expectedOutput)
        )
    }
}
