//
//  SportVM.swift
//  Sports-App
//
//  Created by Adham Samer on 08/02/2023.
//

import Foundation

class ViewModel{
    
    //leagues 
    var bindDataToVC: (() -> Void) = {}
    var leagues: [League]?{
        didSet {
            bindDataToVC()
        }
    }
    
    func getLeagues(endPoint: String) {
        LeaguesService.fetchLeagues(endPoint: endPoint) {result in
            if let result = result{
                self.leagues = result.result
            }
        }
    }
    
    
    
}
