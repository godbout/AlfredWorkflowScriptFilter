import XCTest
@testable import AlfredWorkflowScriptFiltah

final class AlfredWorkflowScriptFiltahTests: XCTestCase {

    func test_that_it_can_return_an_output_where_nothing_has_been_added() {
        let expectedOutput = #"{"items":[]}"#
        let output = ScriptFilter.shared.output()

        XCTAssertEqual(
            expectedOutput,
            output
        )
    }

    func test_that_it_can_return_an_output_with_a_rerun() {
        let expectedOutput = #"{"rerun":1.3,"items":[]}"#
        let output = ScriptFilter.shared
            .rerun(secondsToWait: 1.3)
            .output()

        XCTAssertEqual(
            try JSONSerialization.jsonObject(with: Data(expectedOutput.utf8), options: []) as! NSDictionary,
            try JSONSerialization.jsonObject(with: Data(output.utf8), options: []) as! NSDictionary
        )
    }

}
