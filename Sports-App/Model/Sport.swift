//
//  Sport.swift
//  Sports-App
//
//  Created by Adham Samer on 01/02/2023.
//

import Foundation
class Sport: Decodable {
    var id: Int?
    var slug: String?
    var name: String?
    var name_translations: [String: String]
}

class SportsResult: Decodable {
    var data: [Sport]
}
