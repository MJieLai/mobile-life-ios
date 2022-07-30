//
//  GetImageDetailResponse.swift
//  MobileLifeAssessment
//
//  Created by MJ on 30/07/2022.
//

import Foundation

class GetImageDetailResponse: Decodable {
    var id: String = ""
    var author: String = ""
    var width: Int = 0
    var height: Int = 0
    var url: String = ""
    var download_url: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case width = "width"
        case height = "height"
        case url = "url"
        case download_url = "download_url"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        author = try values.decodeIfPresent(String.self, forKey: .author) ?? ""
        width = try values.decodeIfPresent(Int.self, forKey: .width) ?? 0
        height = try values.decodeIfPresent(Int.self, forKey: .height) ?? 0
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
        download_url = try values.decodeIfPresent(String.self, forKey: .download_url) ?? ""
    }
}
