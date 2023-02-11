//
//  SportVM.swift
//  Sports-App
//
//  Created by Adham Samer on 08/02/2023.
//

import Alamofire
import Foundation

// Sports
class SportsVM {
    var bindDataToSportVC: (() -> Void) = {}
    
    var sports: [Sport] = [] {
        didSet {
            bindDataToSportVC()
        }
    }
    func getSports() {
        SportsService.fetchSports { result in
            self.sports = result?.data ?? []
        }
    }
}

// League Details
class LeagueDetailsVM{
    var bindTeamsToLeagueDVC: (() -> Void) = {}
    var bindEventsToLeagueDVC: (() -> Void) = {}
    var bindResultsToLeagueDVC: (() -> Void) = {}
    
    var teams: [Team] = [] {
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
    
    func getTeams(leagueId:Int) {
        LeagueDetailsService.fetchTeams(completionHandler: { result in
            self.teams = result?.result ?? []
        }, leagueId: leagueId)
    }
    func getEvents(leagueId:Int) {
        LeagueDetailsService.fetchEvents(completionHandler: { result in
            self.events = result?.result ?? []
        }, leagueId: leagueId)
    }
    func getResults(leagueId:Int) {
        LeagueDetailsService.fetchResults(completionHandler: { result in
            self.results = result?.result ?? []
        }, leagueId: leagueId)
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
