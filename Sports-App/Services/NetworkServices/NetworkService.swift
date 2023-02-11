//
//  SportsService.swift
//  Sports-App
//
//  Created by Adham Samer on 08/02/2023.
//

import Alamofire
import Foundation

class LeagueDetailsService: GET_EVENTS, GET_TEAMS, GET_RESULTS {
    static func fetchEvents(completionHandler: @escaping (EventsResult?) -> Void, leagueId: Int) {
        let calendar = Calendar.current
        let cuurentDate = Date()
        let today = cuurentDate.description.split(separator: " ")[0]
        let addDays = DateComponents(day: 15)
        let futureDay = calendar.date(byAdding: addDays, to: cuurentDate)?.description.split(separator: " ")[0]
        
        guard let url = URL(string: "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=aaccf26f834a6b75d941d4aa7c4aee5dbef5268bc87e23941f9c07afa8fc98cc&from=\(today )&to=\(futureDay ?? "")&leagueId=\(leagueId)")else{
            completionHandler(nil)
            return
        }
        AF.request(url, method: .get).response { response in
            switch response.result {
            case  .success(let data):
                do {
                    let json = try JSONDecoder().decode(EventsResult.self, from: data!)
                    completionHandler(json)
                } catch {
                    print(String(describing: error))
                    completionHandler(nil)
                }
            case .failure(let error):
                print(String(describing: error))
                completionHandler(nil)
            }
        }
    
        
        
    }

    static func fetchTeams(completionHandler: @escaping (TeamsResult?) -> Void, leagueId: Int) {
        guard let url = URL(string: "https://apiv2.allsportsapi.com/football/?&Leagues&leagueId=\(leagueId)?&met=Teams&APIkey=aaccf26f834a6b75d941d4aa7c4aee5dbef5268bc87e23941f9c07afa8fc98cc")
        else {
            completionHandler(nil)
            return
        }
        AF.request(url, method: .get).response { response in
            switch response.result {
            case  .success(let data):
                do {
                    let json = try JSONDecoder().decode(TeamsResult.self, from: data!)
                    completionHandler(json)
                } catch {
                    print(String(describing: error))
                    completionHandler(nil)
                }
            case .failure(let error):
                print(String(describing: error))
                completionHandler(nil)
            }
        }
    }

    static func fetchResults(completionHandler: @escaping (ResultsResult?) -> Void, leagueId: Int) {
        let calendar = Calendar.current
        let cuurentDate = Date()
        let today = cuurentDate.description.split(separator: " ")[0]
        let subDays = DateComponents(day: -15)
        let pastDay = calendar.date(byAdding: subDays, to: cuurentDate)?.description.split(separator: " ")[0]
        
        guard let url = URL(string: "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=aaccf26f834a6b75d941d4aa7c4aee5dbef5268bc87e23941f9c07afa8fc98cc&from=\(pastDay ?? "")&to=\(today)&leagueId=\(leagueId)")else{
            completionHandler(nil)
            return
        }
        AF.request(url, method: .get).response { response in
            switch response.result {
            case  .success(let data):
                do {
                    let json = try JSONDecoder().decode(ResultsResult.self, from: data!)
                    completionHandler(json)
                } catch {
                    print(String(describing: error))
                    completionHandler(nil)
                }
            case .failure(let error):
                print(String(describing: error))
                completionHandler(nil)
            }
        }
    }
}


class LeaguesService: GET_LEAGUES {
    static func fetchLeagues(endPoint: String, completionHandler: @escaping (LeaguesResult?) -> Void) {
        let newURL = URL(string: URLService(endPoint: endPoint).url)
        guard let url = newURL else {return}
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case let .success(data):
                do {
                    let json = try JSONDecoder().decode(LeaguesResult?.self, from: data!)
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


