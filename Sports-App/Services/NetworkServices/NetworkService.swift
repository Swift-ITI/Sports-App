//
//  SportsService.swift
//  Sports-App
//
//  Created by Adham Samer on 08/02/2023.
//

import Alamofire
import Foundation

class LeagueDetailsService: GET_EVENTS, GET_TEAMS, GET_RESULTS {
    static func fetchEvents(completionHandler: @escaping (EventsResult?) -> Void, leagueId: Int, sportId: String) {
        let calendar = Calendar.current
        let cuurentDate = Date()
        let today = cuurentDate.description.split(separator: " ")[0]
        let addDays = DateComponents(month: 3)
        let futureDay = calendar.date(byAdding: addDays, to: cuurentDate)?.description.split(separator: " ")[0]

        guard let url = URL(string: "https://apiv2.allsportsapi.com/\(sportId)/?met=Fixtures&APIkey=6006e0bee72004ccef17f23f6ab68d967e8deb5c4340ab2b656fa19f0497cb5a&from=\(today)&to=\(futureDay ?? "")&leagueId=\(leagueId)") else {
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

    static func fetchTeams(completionHandler: @escaping (TeamsResult?) -> Void, leagueId: Int, sportId: String) {
        guard let url = URL(string: "https://apiv2.allsportsapi.com/\(sportId)/?&Leagues&leagueId=\(leagueId)?&met=Teams&APIkey=6006e0bee72004ccef17f23f6ab68d967e8deb5c4340ab2b656fa19f0497cb5a")
        else {
            completionHandler(nil)
            return
        }

        AF.request(url, method: .get).response { response in
            switch response.result {
            case let .success(data):
                guard let data = data else { completionHandler(nil)
                    return
                }
                do {
                    let json = try JSONDecoder().decode(TeamsResult.self, from: data)
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

    static func fetchResults(completionHandler: @escaping (ResultsResult?) -> Void, leagueId: Int, sportId: String) {
        let calendar = Calendar.current
        let cuurentDate = Date()
        let today = cuurentDate.description.split(separator: " ")[0]
        let subDays = DateComponents(month: -3)
        let pastDay = calendar.date(byAdding: subDays, to: cuurentDate)?.description.split(separator: " ")[0]

        guard let url = URL(string: "https://apiv2.allsportsapi.com/\(sportId)/?met=Fixtures&APIkey=6006e0bee72004ccef17f23f6ab68d967e8deb5c4340ab2b656fa19f0497cb5a&from=\(pastDay ?? "")&to=\(today)&leagueId=\(leagueId)") else {
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

class LeaguesService: GET_LEAGUES {
    static func fetchLeagues(endPoint: String, completionHandler: @escaping (LeagueResult?) -> Void) {
        let newURL = URL(string: URLService(endPoint: endPoint).url)
        guard let url = newURL else { return }
        AF.request(url, method: .get).response { response in
            switch response.result {
            case let .success(data):
                do {
                    let json = try JSONDecoder().decode(LeagueResult?.self, from: data!)
                    completionHandler(json)
                } catch {
                    print(error.localizedDescription)
                    completionHandler(nil)
                }
            case let .failure(error):
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
}
