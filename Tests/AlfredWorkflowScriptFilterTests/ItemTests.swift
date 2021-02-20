@testable import AlfredWorkflowScriptFilter
import XCTest

class ItemTests: XCTestCase {
    func test_that_it_requires_at_least_a_title_a_subtitle_and_an_icon() {
        let item = Item.create(title: "title", subtitle: "subtitle", icon: Icon())
    }
}
