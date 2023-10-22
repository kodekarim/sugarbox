

import Foundation
struct Sections : Decodable, Hashable {
	let _id : String?
	let contentId : String?
	let createdAt : String?
	let description : String?
	let title : String?
	let updatedAt : String?
	let contents : [Contents]?
	let id : String?
	let addedOn : String?
	let designId : DesignId?
	let designMeta : DesignMeta?
	let designSlug : String?
	let widgetType : String?

	enum CodingKeys: String, CodingKey {

		case _id = "_id"
		case contentId = "contentId"
		case createdAt = "createdAt"
		case description = "description"
		case title = "title"
		case updatedAt = "updatedAt"
		case contents = "contents"
		case id = "id"
		case addedOn = "addedOn"
		case designId = "designId"
		case designMeta = "designMeta"
		case designSlug = "designSlug"
		case widgetType = "widgetType"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		_id = try values.decodeIfPresent(String.self, forKey: ._id)
		contentId = try values.decodeIfPresent(String.self, forKey: .contentId)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
		contents = try values.decodeIfPresent([Contents].self, forKey: .contents)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		addedOn = try values.decodeIfPresent(String.self, forKey: .addedOn)
		designId = try values.decodeIfPresent(DesignId.self, forKey: .designId)
		designMeta = try values.decodeIfPresent(DesignMeta.self, forKey: .designMeta)
		designSlug = try values.decodeIfPresent(String.self, forKey: .designSlug)
		widgetType = try values.decodeIfPresent(String.self, forKey: .widgetType)
	}

}
