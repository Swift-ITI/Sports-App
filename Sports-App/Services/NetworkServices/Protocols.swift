//
//  APIServices.swift
//  Sports-App
//
//  Created by Adham Samer on 08/02/2023.
//

import Foundation

protocol GET_LEAGUES{
    static func fetchLeagues(endPoint: String, completionHandler: @escaping (LeaguesResult?) -> Void)
}

protocol GET_EVENTS {
    static func fetchEvents(completionHandler: @escaping (EventsResult?) -> Void,leagueId:Int)
}
protocol GET_TEAMS {
    static func fetchTeams(completionHandler: @escaping (TeamsResult?) -> Void,leagueId:Int)
}
protocol GET_RESULTS {
    static func fetchResults(completionHandler: @escaping (ResultsResult?) -> Void,leagueId:Int)
}
