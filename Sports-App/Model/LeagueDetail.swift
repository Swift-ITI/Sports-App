//
//  LeagueDetail.swift
//  Sports-App
//
//  Created by Adham Samer on 01/02/2023.
//

import Foundation
class Event: Decodable {
    var event_key: Int?
    var event_date: String?
    var event_time: String?
    var event_home_team: String?
    var event_away_team: String?
    var event_final_result: String?
    var country_name: String?
    var league_name: String?
    var league_key: Int?
    var league_round: String?
    var league_season: String?
    var event_live: String?
    var event_stadium: String?
    var event_referee: String?
    var home_team_logo: String?
    var away_team_logo: String?
    var event_country_key: Int?
    var league_logo: String?
    var country_logo: String?
    //tennis
    var event_first_player: String?
    var event_second_player: String?
    var event_game_result: String?
    var event_winner: String?
    var event_first_player_logo: String?
    var event_second_player_logo: String?
    var first_player_key: String?
    var second_player_key: String?
    //basket
    var event_home_team_logo: String?
    var event_away_team_logo: String?
    //cricket
    var event_date_start: String?
}

class EventsResult: Decodable {
    var result: [Event]
}

class Teams: Decodable {
    var team_key: Int?
    var team_name: String?
    var team_logo: String?
    var players: [Player]
}

class Player: Decodable{
    var player_name: String?
    var player_type: String?
    var player_number: String?
    var player_image: String?
}

class TeamsResult: Decodable {
    var result: [Teams]
    var tennisResult: [TennisPlayers]
    
}

class TennisPlayers: Decodable{
    var player_key: String?
    var player_name: String?
    var player_country: String?
    var player_bday: String?
    var player_logo: String?
    var stats: [Stats]?
}

class Stats: Decodable{
    var season: String
    var type: String?
    var rank: String?
    var titles: String?
    var matches_won: String?
    var matches_lost: String?
    var hard_won: String?
    var hard_lost: String?
    var clay_won: String?
    var clay_lost: String?
    var grass_won: String?
    var grass_lost: String?
}

class Result: Decodable {
    var event_key: Int?
    var event_date: String?
    var event_time: String?
    var event_home_team: String?
    var event_away_team: String?
    var event_final_result: String?
    var country_name: String?
    var league_name: String?
    var league_key: Int?
    var league_round: String?
    var league_season: String?
    var event_live: String?
    var event_stadium: String?
    var event_referee: String?
    var home_team_logo: String?
    var away_team_logo: String?
    var event_country_key: Int?
    var league_logo: String?
    var country_logo: String?
    //tennis
    var event_first_player: String?
    var event_second_player: String?
    var event_game_result: String?
    var event_winner: String?
    var event_first_player_logo: String?
    var event_second_player_logo: String?
    var first_player_key: String?
    var second_player_key: String?
    //basket
    var event_home_team_logo: String?
    var event_away_team_logo: String?
    //cricket
    var event_date_stop: String?
    var event_status: String?
}

class ResultsResult: Decodable {
    var result: [Result]
}


