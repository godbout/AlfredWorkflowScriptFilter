@testable import AlfredWorkflowScriptFilter
import XCTest

class ItemTextsTests: XCTestCase {
    private var item: Item?

    override func setUp() {
        super.setUp()

        item = Item(title: "text me xoxo")
    }
}

extension ItemTextsTests {
    func test_that_it_may_set_a_copy_value() throws {
        item?.text("paste", for: .copy)

        let expectedOutput = """
        {
            "title": "text me xoxo",
            "text": {
                "copy": "paste"
            }
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_it_may_set_a_largetype_value() throws {
        item?.text("XXL", for: .largetype)

        let expectedOutput = """
        {
            "title": "text me xoxo",
            "text": {
                "largetype": "XXL"
            }
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }
}
