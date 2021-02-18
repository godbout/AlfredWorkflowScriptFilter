@testable import AlfredWorkflowScriptFilter
import XCTest

final class ScriptFilterTests: XCTestCase {
    private let scriptFilter = ScriptFilter.shared

    override func tearDown() {
        scriptFilter.reset()

        super.tearDown()
    }

    func test_that_it_may_contain_nothing() {
        let output = scriptFilter.output()
        let expectedOutput = #"{"items":[]}"#

        XCTAssertEqual(
            output,
            expectedOutput
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

    func test_that_it_may_contain_one_variable() {
        let variable = Variable.create(name: "fruit", value: "tomato")

        let output = scriptFilter.add(variable).output()
        let expectedOutput = #"{"variables":{"fruit":"tomato"},"items":[]}"#

        XCTAssertEqual(
            try JSONSerialization.jsonObject(with: Data(output.utf8), options: []) as! NSDictionary,
            try JSONSerialization.jsonObject(with: Data(expectedOutput.utf8), options: []) as! NSDictionary
        )
    }

    func test_that_it_may_contain_several_variables() {
        let firstVariable = Variable.create(name: "fruit", value: "cucumber")
        let secondVariable = Variable.create(name: "vegetable", value: "rhubarb")

        scriptFilter.add(firstVariable)
        scriptFilter.add(secondVariable)

        let expectedOutput = #"{"variables":{"fruit":"cucumber","vegetable":"rhubarb"},"items":[]}"#
        let output = scriptFilter.output()

        XCTAssertEqual(
            try JSONSerialization.jsonObject(with: Data(output.utf8), options: []) as! NSDictionary,
            try JSONSerialization.jsonObject(with: Data(expectedOutput.utf8), options: []) as! NSDictionary
        )
    }

    func test_that_adding_an_empty_variable_results_in_an_empty_JSON_variable_object() {
        let variable = Variable.create()

        scriptFilter.add(variable)

        let expectedOutput = #"{"variables":{},"items":[]}"#
        let output = scriptFilter.output()

        XCTAssertEqual(
            try JSONSerialization.jsonObject(with: Data(output.utf8), options: []) as! NSDictionary,
            try JSONSerialization.jsonObject(with: Data(expectedOutput.utf8), options: []) as! NSDictionary
        )
    }
}
