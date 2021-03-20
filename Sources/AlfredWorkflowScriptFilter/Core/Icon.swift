import Foundation

public enum IconType: String, Codable {
    case fileicon
    case filetype
}

public final class Icon {
    public var path: String
    public var type: IconType?

    public init(path: String, type: IconType? = nil) {
        self.path = path
        self.type = type
    }

    @discardableResult
    public func path(_ path: String) -> Icon {
        self.path = path

        return self
    }

    @discardableResult
    public func type(_ type: IconType) -> Icon {
        self.type = type

        return self
    }
}

extension Icon: Codable {}

extension Icon: Equatable {
    public static func == (lhs: Icon, rhs: Icon) -> Bool {
        lhs.path == rhs.path
            && lhs.type == rhs.type
    }
}
