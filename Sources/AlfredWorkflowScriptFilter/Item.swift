import Foundation

struct Item {
    private let title: String

    static func create(title: String) -> Item {
        Item(title: title)
    }
}

extension Item: Codable {}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.title == rhs.title
    }
}
