//
//  MockLeaguesServices.swift
//  Sports-AppTests
//
//  Created by MESHO on 14/02/2023.
//

import Foundation
@testable import Sports_App

class MockLeagueService {

    static let mockItemsJSONResponse: String = "{\"result\":[{\"league_key\":\"tt1630029\"},{\"country_name\":\"1\"},{\"league_name\":\"Avatar: The Way of Water\"},{\"league_logo\":\"https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_Ratio0.7015_AL_.jpg\"}]}"
    
}


extension MockLeagueService: GET_LEAGUES{
    static func fetchLeagues(endPoint: String, completionHandler: @escaping (LeagueResult?) -> Void) {
        let data = Data(mockItemsJSONResponse.utf8)
        do {
            let response = try JSONDecoder().decode(LeagueResult.self, from: data)
            completionHandler(response)
        } catch {
            completionHandler(nil)
        }
    }
    
    
}

