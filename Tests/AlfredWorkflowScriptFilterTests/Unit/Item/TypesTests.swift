import AlfredWorkflowScriptFilter
import XCTest

class ItemTypesTests: XCTestCase {
    private var item: Item?

    override func setUp() {
        super.setUp()

        item = Item(title: "you're not my type")
    }
}

extension ItemTypesTests {
    func test_that_it_may_be_of_type_default() throws {
        item?.type(.default)

        let expectedOutput = """
        {
            "title": "you're not my type",
            "type": "default",
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_it_may_be_of_type_file() throws {
        item?.type(.file)

        let expectedOutput = """
        {
            "title": "you're not my type",
            "type": "file",
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_it_may_be_of_type_fileSkipcheck() throws {
        item?.type(.fileSkipcheck)

        let expectedOutput = """
        {
            "title": "you're not my type",
            "type": "file:skipcheck",
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }
}
