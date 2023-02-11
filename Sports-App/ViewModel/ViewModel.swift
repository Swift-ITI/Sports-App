//
//  SportVM.swift
//  Sports-App
//
//  Created by Adham Samer on 08/02/2023.
//

import Foundation

class leaguesVM {
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
