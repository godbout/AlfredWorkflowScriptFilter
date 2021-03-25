import AlfredWorkflowScriptFilter
import XCTest

class ItemIconsTests: XCTestCase {
    private var item: Item?

    override func setUp() {
        super.setUp()

        item = Item(title: "i'm an item with some icons LOL")
    }
}

extension ItemIconsTests {
    func test_that_it_may_have_an_icon() throws {
        item?.icon(Icon(path: "the path"))

        let expectedOutput = """
        {
            "title": "i'm an item with some icons LOL",
            "icon": {
                "path": "the path"
            }
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_it_may_have_an_icon_of_type_fileicon() throws {
        item?.icon(
            Icon(path: "another path Bites the Dust")
                .type(.fileicon)
        )

        let expectedOutput = """
        {
            "title": "i'm an item with some icons LOL",
            "icon": {
                "path": "another path Bites the Dust",
                "type": "fileicon"
            }
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_it_may_have_an_icon_of_type_filetype() throws {
        item?.icon(
            Icon(path: "caminho", type: .filetype)
        )

        let expectedOutput = """
        {
            "title": "i'm an item with some icons LOL",
            "icon": {
                "path": "caminho",
                "type": "filetype"
            }
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }

    func test_that_it_cannot_have_multiple_icons() throws {
        item?.icon(Icon(path: "path1"))
        item?.icon(Icon(path: "path2"))

        let expectedOutput = """
        {
            "title": "i'm an item with some icons LOL",
            "icon": {
                "path": "path2",
            }
        }
        """

        XCTAssertEqual(
            item,
            try JSONHelper().itemObject(from: expectedOutput)
        )
    }
}
