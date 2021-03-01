@testable import AlfredWorkflowScriptFilter
import XCTest

class ModTests: XCTestCase {
    func test_that_it_may_have_a_subtitle() throws {
        let mod = Ctrl(subtitle: "eng.srt")

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
        let mod = Cmd(arg: "nice arg, babe.")

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
}
