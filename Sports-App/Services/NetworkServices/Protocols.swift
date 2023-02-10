//
//  APIServices.swift
//  Sports-App
//
//  Created by Adham Samer on 08/02/2023.
//

import Foundation
protocol GET_SPORTS {
    static func fetchSports(completionHandler: @escaping (SportsResult?) -> Void)
}

protocol GET_LEAGUES {
    static func fetchLeagues()
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
