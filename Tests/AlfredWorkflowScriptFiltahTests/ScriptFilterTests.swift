import XCTest
@testable import AlfredWorkflowScriptFiltah

final class AlfredWorkflowScriptFiltahTests: XCTestCase {
    private let scriptFilter = ScriptFilter.shared

    func test_that_it_may_contain_nothing() {
        let expectedOutput = #"{"items":[]}"#
        let output = scriptFilter.output()

        XCTAssertEqual(
            expectedOutput,
            output
        )
    }

    func test_that_it_may_contain_a_rerun() {
        XCTAssertEqual(
            scriptFilter.rerun(secondsToWait: 0.0).output(),
            #"{"items":[]}"#
        )

        XCTAssertEqual(
            scriptFilter.rerun(secondsToWait: 5.1).output(),
            #"{"items":[]}"#
        )

        let output = scriptFilter.rerun(secondsToWait: 1.3).output()
        let expectedOutput = #"{"rerun":1.3,"items":[]}"#

        XCTAssertEqual(
            try JSONSerialization.jsonObject(with: Data(output.utf8), options: []) as! NSDictionary,
            try JSONSerialization.jsonObject(with: Data(expectedOutput.utf8), options: []) as! NSDictionary
        )
    }
}
