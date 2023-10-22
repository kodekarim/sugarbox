

import Foundation
struct Assets : Decodable, Hashable {
	let assetType : String?
	let sourceUrl : String?
	let type : String?
	let sourcePath : String?

	enum CodingKeys: String, CodingKey {

		case assetType = "assetType"
		case sourceUrl = "sourceUrl"
		case type = "type"
		case sourcePath = "sourcePath"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		assetType = try values.decodeIfPresent(String.self, forKey: .assetType)
		sourceUrl = try values.decodeIfPresent(String.self, forKey: .sourceUrl)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		sourcePath = try values.decodeIfPresent(String.self, forKey: .sourcePath)
	}

}
