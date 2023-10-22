

import Foundation
struct MetaData : Decodable, Hashable {
	let duration : Int?
	let isNonCompressed : Bool?
	let episode_number : Int?
	let enableDownloadOnDongle : Bool?
	let hasAssets : Bool?
	let shouldHaveChildren : Bool?
	let ageRating : String?

	enum CodingKeys: String, CodingKey {

		case duration = "duration"
		case isNonCompressed = "isNonCompressed"
		case episode_number = "episode_number"
		case enableDownloadOnDongle = "enableDownloadOnDongle"
		case hasAssets = "hasAssets"
		case shouldHaveChildren = "shouldHaveChildren"
		case ageRating = "ageRating"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		duration = try values.decodeIfPresent(Int.self, forKey: .duration)
		isNonCompressed = try values.decodeIfPresent(Bool.self, forKey: .isNonCompressed)
		episode_number = try values.decodeIfPresent(Int.self, forKey: .episode_number)
		enableDownloadOnDongle = try values.decodeIfPresent(Bool.self, forKey: .enableDownloadOnDongle)
		hasAssets = try values.decodeIfPresent(Bool.self, forKey: .hasAssets)
		shouldHaveChildren = try values.decodeIfPresent(Bool.self, forKey: .shouldHaveChildren)
		ageRating = try values.decodeIfPresent(String.self, forKey: .ageRating)
	}

}
