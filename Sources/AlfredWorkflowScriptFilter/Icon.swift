import Foundation

enum IconType: String, Codable {
    case fileicon
    case filetype
}

struct Icon {
    private let path: String
    private let type: IconType?

    static func create(path: String, type: IconType? = nil) -> Icon {
        Icon(path: path, type: type)
    }
}

extension Icon: Codable {}

extension Icon: Equatable {
    static func == (lhs: Icon, rhs: Icon) -> Bool {
        lhs.path == rhs.path
            && lhs.type == rhs.type
    }
}
