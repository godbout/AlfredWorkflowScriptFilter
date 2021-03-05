@testable import AlfredWorkflowScriptFilter
import XCTest

class IconTests: XCTestCase {
    func test_that_it_may_not_contain_a_type() throws {
        let icon = Icon(path: "~/Desktop")

        let expectedOutput = """
        {
            "path": "~/Desktop"
        }
        """

        XCTAssertEqual(
            icon,
            try JSONHelper().iconObject(from: expectedOutput)
        )
    }

    func test_that_it_may_be_a_fileicon_type() throws {
        let icon = Icon(path: "C:/Windows/LOL", type: .fileicon)

        let expectedOutput = """
        {
            "path": "C:/Windows/LOL",
            "type": "fileicon"
        }
        """

        XCTAssertEqual(
            icon,
            try JSONHelper().iconObject(from: expectedOutput)
        )
    }

    func test_that_it_may_be_a_filetype_type() throws {
        let icon = Icon(path: "chemin", type: .filetype)

        let expectedOutput = """
        {
            "path": "chemin",
            "type": "filetype"
        }
        """

        XCTAssertEqual(
            icon,
            try JSONHelper().iconObject(from: expectedOutput)
        )
    }
}
