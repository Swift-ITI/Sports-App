//
//  SportVM.swift
//  Sports-App
//
//  Created by Adham Samer on 08/02/2023.
//

import Alamofire
import Foundation

// League Details
class LeagueDetailsVM{
    var bindTeamsToLeagueDVC: (() -> Void) = {}
    var bindEventsToLeagueDVC: (() -> Void) = {}
    var bindResultsToLeagueDVC: (() -> Void) = {}
    
    var teams: [Teams] = [] {
        didSet {
            bindTeamsToLeagueDVC()
        }
    }
    var events: [Event] = [] {
        didSet {
            bindEventsToLeagueDVC()
        }
    }
    var results: [Result] = [] {
        didSet {
            bindResultsToLeagueDVC()
        }
    }
    
    func getTeams(leagueId:Int,sportId:String) {
        LeagueDetailsService.fetchTeams(completionHandler: { result in
            self.teams = result?.result ?? []
        }, leagueId: leagueId, sportId:sportId)
    }
    func getEvents(leagueId:Int,sportId:String) {
        LeagueDetailsService.fetchEvents(completionHandler: { result in
            self.events = result?.result ?? []
        }, leagueId: leagueId, sportId:sportId)
    }
    func getResults(leagueId:Int,sportId:String) {
        LeagueDetailsService.fetchResults(completionHandler: { result in
            self.results = result?.result ?? []
        }, leagueId: leagueId, sportId:sportId)
    }
}


class LeaguesVM {
    // leagues
    var bindLeaguesToVC: (() -> Void) = {}
    var leagues: [League]? {
        didSet {
            bindLeaguesToVC()
        }
    }

    func getLeagues(endPoint: String) {
        LeaguesService.fetchLeagues(endPoint: endPoint) { result in
            if let result = result {
                self.leagues = result.result
            }
        }
    }
}
