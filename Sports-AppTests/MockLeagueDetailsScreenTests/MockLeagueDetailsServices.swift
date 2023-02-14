//
//  MockLeagueDetailsServices.swift
//  Sports-AppTests
//
//  Created by MESHO on 14/02/2023.
//

import Foundation
@testable import Sports_App

class MockLeagueDetailsService {

    static let mockItemsJSONResponse: String = "{\"result\":[{\"league_key\":\"tt1630029\"},{\"country_name\":\"1\"},{\"league_name\":\"Avatar: The Way of Water\"},{\"league_logo\":\"https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_Ratio0.7015_AL_.jpg\"}]}"
    
}


extension MockLeagueDetailsService: GET_EVENTS, GET_TEAMS, GET_RESULTS{
    static func fetchEvents(completionHandler: @escaping (Sports_App.EventsResult?) -> Void, leagueId: Int, sportId: String) {
        <#code#>
    }
    
    static func fetchTeams(completionHandler: @escaping (Sports_App.TeamsResult?) -> Void, leagueId: Int, sportId: String) {
        <#code#>
    }
    
    static func fetchResults(completionHandler: @escaping (Sports_App.ResultsResult?) -> Void, leagueId: Int, sportId: String) {
        <#code#>
    }
    
    static func fetchLeagues(endPoint: String, completionHandler: @escaping ([League]?) -> Void) {
        let data = Data(mockItemsJSONResponse.utf8)
        do {
            let response = try JSONDecoder().decode(LeagueResult.self, from: data)
            completionHandler(response.result)
        } catch {
            completionHandler(nil)
        }
    }
    
    
}
