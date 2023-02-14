//
//  MockLeagueDetailsServices.swift
//  Sports-AppTests
//
//  Created by MESHO on 14/02/2023.
//

import Foundation
import Alamofire
@testable import Sports_App

class MockLeagueDetailsService {

    static let mockUpcomingEventsJSONRespond: String = "{\"results\":[{\"event_date\":\"2023-02-23\"},{\"event_date\":\"2023-02-24\"}]}"
       static let mockLatestEventsJSONRespond: String = "{\"results\":[{\"event_date\":\"2023-02-23\"},{\"event_date\":\"2023-02-24\"}]}"
       static let mockTeamsDetailsJSONRespond: String = "{\"results\":[{\"team_name\":\"BayernMunich\"},{\"team_logo\":\"https://apiv2.allsportsapi.com/logo/72_bayern-munich.jpg\"}]}"
   }


extension MockLeagueDetailsService: GET_EVENTS, GET_TEAMS, GET_RESULTS{

    static func fetchEvents(completionHandler: @escaping (EventsResult?) -> Void, leagueId: Int, sportId: String) {
        
        guard let url = URL(string: "https://apiv2.allsportsapi.com/\(sportId)/?met=Fixtures&leagueId=\(leagueId)&from=2023-01-18&to=2024-01-18&APIkey=c5ebd307b70cdd257579522744048f245836e9714d8a72205ec5cad867dd165a") else {
            completionHandler(nil)
            return
        }
        AF.request(url, method: .get).response { response in
            switch response.result {
            case let .success(data):
                do {
                    let json = try JSONDecoder().decode(EventsResult.self, from: data!)
                    completionHandler(json)
                } catch {
                    print(String(describing: error))
                    completionHandler(nil)
                }
            case let .failure(error):
                print(String(describing: error))
                completionHandler(nil)
            }
        }
    }
    static func fetchTeams(completionHandler: @escaping (Sports_App.TeamsResult?) -> Void, leagueId: Int, sportId: String) {
        guard let url = URL(string: "https://apiv2.allsportsapi.com/\(sportId)/?met=Fixtures&leagueId=\(leagueId)&from=2023-01-18&to=2024-01-18&APIkey=c5ebd307b70cdd257579522744048f245836e9714d8a72205ec5cad867dd165a") else {
            completionHandler(nil)
            return
        }
        AF.request(url, method: .get).response { response in
            switch response.result {
            case let .success(data):
                do {
                    let json = try JSONDecoder().decode(TeamsResult.self, from: data!)
                    completionHandler(json)
                } catch {
                    print(String(describing: error))
                    completionHandler(nil)
                }
            case let .failure(error):
                print(String(describing: error))
                completionHandler(nil)
            }
        }
    }
    
    static func fetchResults(completionHandler: @escaping (Sports_App.ResultsResult?) -> Void, leagueId: Int, sportId: String) {
        guard let url = URL(string: "https://apiv2.allsportsapi.com/\(sportId)/?met=Fixtures&leagueId=\(leagueId)&from=2023-01-18&to=2024-01-18&APIkey=c5ebd307b70cdd257579522744048f245836e9714d8a72205ec5cad867dd165a") else {
            completionHandler(nil)
            return
        }
        AF.request(url, method: .get).response { response in
            switch response.result {
            case let .success(data):
                do {
                    let json = try JSONDecoder().decode(ResultsResult.self, from: data!)
                    completionHandler(json)
                } catch {
                    print(String(describing: error))
                    completionHandler(nil)
                }
            case let .failure(error):
                print(String(describing: error))
                completionHandler(nil)
            }
        }
    }

}
    
