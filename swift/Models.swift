import Foundation

// MARK: - Shared localized types

public struct Localized: Codable, Hashable {
  public let en: String
  public let hi: String
  public let gu: String
}

public struct Gradient: Codable, Hashable {
  public let start: String
  public let end: String
}

// MARK: - Items (data/<category>.json)

public enum ItemID: Hashable {
  case string(String)
  case int(Int)
}

extension ItemID: Codable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let i = try? container.decode(Int.self) {
      self = .int(i)
    } else if let s = try? container.decode(String.self) {
      self = .string(s)
    } else {
      throw DecodingError.typeMismatch(
        ItemID.self,
        .init(codingPath: decoder.codingPath, debugDescription: "Expected String or Int for id")
      )
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .int(let v): try container.encode(v)
    case .string(let v): try container.encode(v)
    }
  }
}

public struct ItemMedia: Codable, Hashable {
  public let image: String
}

public struct ItemAccessibility: Codable, Hashable {
  public let altText: Localized
}

public struct ItemMeta: Codable, Hashable {
  public let category: String
  public let order: Int
}

public struct LearningItem: Codable, Identifiable, Hashable {
  public let id: ItemID
  public let slug: String
  public let name: Localized
  public let media: ItemMedia
  public let meta: ItemMeta
  public let tags: [String]
  public let accessibility: ItemAccessibility
}

public typealias LearningItemList = [LearningItem]

// MARK: - Categories Index (data/index.json)

public enum Difficulty: String, Codable {
  case easy, medium, hard
}

public struct CategoryMeta: Codable, Hashable {
  public let category: String
  public let order: Int
}

public struct CategoryIndexEntry: Codable, Identifiable, Hashable {
  public let index: Int
  public let id: Int
  public let title: Localized
  public let slug: String
  public let type: String
  public let imageURL: String?
  public let icon: String
  public let description: Localized
  public let tags: [String]
  public let meta: CategoryMeta
  public let primaryColor: String
  public let secondaryColor: String
  public let gradient: Gradient
  public let difficulty: Difficulty
  public let featured: Bool
  public let locale: [String]
  public let altTitle: Localized
}

public typealias CategoryIndex = [CategoryIndexEntry]
