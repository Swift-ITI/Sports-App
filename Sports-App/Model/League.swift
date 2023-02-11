//
//  League.swift
//  Sports-App
//
//  Created by Adham Samer on 01/02/2023.
//

import Foundation

class League: Decodable {
    var league_key: Int?
    var league_name: String?
    var country_name: String?
    var league_logo: String?
    
}

class LeaguesResult: Decodable {
    var success: Int
    var result: [League]
}
