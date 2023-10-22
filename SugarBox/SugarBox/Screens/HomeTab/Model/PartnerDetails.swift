

import Foundation
struct PartnerDetails : Decodable, Hashable {
	let partnerId : Int?
	let partnerName : String?
	let partnerShortName : String?

	enum CodingKeys: String, CodingKey {

		case partnerId = "partnerId"
		case partnerName = "partnerName"
		case partnerShortName = "partnerShortName"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		partnerId = try values.decodeIfPresent(Int.self, forKey: .partnerId)
		partnerName = try values.decodeIfPresent(String.self, forKey: .partnerName)
		partnerShortName = try values.decodeIfPresent(String.self, forKey: .partnerShortName)
	}

}
