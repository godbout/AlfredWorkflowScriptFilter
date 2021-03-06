import Foundation

enum IconType: String, Codable {
    case fileicon
    case filetype
}

final class Icon {
    private var path: String
    private var type: IconType?

    init(path: String, type: IconType? = nil) {
        self.path = path
        self.type = type
    }

    @discardableResult
    func path(_ path: String) -> Icon {
        self.path = path

        return self
    }

    @discardableResult
    func type(_ type: IconType) -> Icon {
        self.type = type

        return self
    }
}

extension Icon: Codable {}

extension Icon: Equatable {
    static func == (lhs: Icon, rhs: Icon) -> Bool {
        lhs.path == rhs.path
            && lhs.type == rhs.type
    }
}
