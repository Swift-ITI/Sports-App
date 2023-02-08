//
//  SportVM.swift
//  Sports-App
//
//  Created by Adham Samer on 08/02/2023.
//

import Alamofire
import Foundation

class SportVM {
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
