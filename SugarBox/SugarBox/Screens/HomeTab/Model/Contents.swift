

import Foundation
struct Contents : Decodable, Hashable {
	let _id : String?
	let contentId : String?
	let assets : [Assets]?
	let contentType : String?
	let description : String?
	let isLicensed : Bool?
	let metaData : MetaData?
	let partnerContentId : String?
	let partnerId : Int?
	let releaseDate : String?
	let title : String?
	let partnerDetails : PartnerDetails?
	let partnerName : String?
	let addedOn : String?

	enum CodingKeys: String, CodingKey {

		case _id = "_id"
		case contentId = "contentId"
		case assets = "assets"
		case contentType = "contentType"
		case description = "description"
		case isLicensed = "isLicensed"
		case metaData = "metaData"
		case partnerContentId = "partnerContentId"
		case partnerId = "partnerId"
		case releaseDate = "releaseDate"
		case title = "title"
		case partnerDetails = "partnerDetails"
		case partnerName = "partnerName"
		case addedOn = "addedOn"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		_id = try values.decodeIfPresent(String.self, forKey: ._id)
		contentId = try values.decodeIfPresent(String.self, forKey: .contentId)
		assets = try values.decodeIfPresent([Assets].self, forKey: .assets)
		contentType = try values.decodeIfPresent(String.self, forKey: .contentType)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		isLicensed = try values.decodeIfPresent(Bool.self, forKey: .isLicensed)
		metaData = try values.decodeIfPresent(MetaData.self, forKey: .metaData)
		partnerContentId = try values.decodeIfPresent(String.self, forKey: .partnerContentId)
		partnerId = try values.decodeIfPresent(Int.self, forKey: .partnerId)
		releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		partnerDetails = try values.decodeIfPresent(PartnerDetails.self, forKey: .partnerDetails)
		partnerName = try values.decodeIfPresent(String.self, forKey: .partnerName)
		addedOn = try values.decodeIfPresent(String.self, forKey: .addedOn)
	}

}
