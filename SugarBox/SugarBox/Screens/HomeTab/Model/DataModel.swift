

import Foundation
struct DataModel : Decodable, Hashable {
	let sections : [Sections]?
	let pagination : Pagination?

	enum CodingKeys: String, CodingKey {

		case data = "data"
		case pagination = "pagination"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        sections = try values.decodeIfPresent([Sections].self, forKey: .data)
		pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
	}

}
