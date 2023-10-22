

import Foundation
struct Pagination : Decodable, Hashable {
	let totalPages : Int?
	let currentPage : Int?
	let perPage : Int?
	let totalCount : Int?

	enum CodingKeys: String, CodingKey {

		case totalPages = "totalPages"
		case currentPage = "currentPage"
		case perPage = "perPage"
		case totalCount = "totalCount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
		currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage)
		perPage = try values.decodeIfPresent(Int.self, forKey: .perPage)
		totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
	}

}
