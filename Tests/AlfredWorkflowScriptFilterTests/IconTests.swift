@testable import AlfredWorkflowScriptFilter
import XCTest

class IconTests: XCTestCase {
    func iconObject(from json: String) throws -> Icon? {
        try JSONDecoder().decode(Icon.self, from: json.data(using: .utf8) ?? Data())
    }
}

extension IconTests {
    func test_that_it_may_not_contain_a_type() throws {
        let icon = Icon.create(path: "~/Desktop")

        let expectedOutput = """
        {
            "path": "~/Desktop"
        }
        """

        XCTAssertEqual(
            icon,
            try iconObject(from: expectedOutput)
        )
    }

    func test_that_it_may_be_a_fileicon_type() throws {
        let icon = Icon.create(path: "C:/Windows/LOL", type: .fileicon)

        let expectedOutput = """
        {
            "path": "C:/Windows/LOL",
            "type": "fileicon"
        }
        """

        XCTAssertEqual(
            icon,
            try iconObject(from: expectedOutput)
        )
    }

    func test_that_it_may_be_a_filetype_type() throws {
        let icon = Icon.create(path: "chemin", type: .filetype)

        let expectedOutput = """
        {
            "path": "chemin",
            "type": "filetype"
        }
        """

        XCTAssertEqual(
            icon,
            try iconObject(from: expectedOutput)
        )
    }
}
