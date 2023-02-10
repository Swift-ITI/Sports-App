//
//  APIServices.swift
//  Sports-App
//
//  Created by Adham Samer on 08/02/2023.
//

import Foundation

//protocol GET_SPORTS{
//    static func fetchSports(endPoint: String, completionHandler: @escaping (SportsResult?) -> Void)
//}

protocol GET_LEAGUES{
    static func fetchLeagues(endPoint: String, completionHandler: @escaping (LeaguesResult?) -> Void)
}

protocol GET_EVENTS{
    static func fetchEvents(endPoint: String)
}

protocol GET_TEAMS{
    static func fetchTeams(endPoint: String)
}

protocol GET_RESULTS{
    static func fetchResults(endPoint: String)
}
