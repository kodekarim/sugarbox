

import Foundation
struct DesignId : Decodable, Hashable {
	let _id : String?
	let designSlug : String?

	enum CodingKeys: String, CodingKey {

		case _id = "_id"
		case designSlug = "designSlug"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		_id = try values.decodeIfPresent(String.self, forKey: ._id)
		designSlug = try values.decodeIfPresent(String.self, forKey: .designSlug)
	}

}
