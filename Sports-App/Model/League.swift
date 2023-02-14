//
//  League.swift
//  Sports-App
//
//  Created by Adham Samer on 01/02/2023.
//

import Foundation
import CoreData

class League: Decodable {
    var league_key: Int?
    var league_name: String?
    var country_name: String?
    var league_logo: String?
    var league_year: String?
//    var isLiked: Bool = false
}

class LeaguesResult: Decodable {
    var success: Int = 0
    var result: [League]
}
