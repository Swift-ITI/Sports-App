//
//  SportsService.swift
//  Sports-App
//
//  Created by Adham Samer on 08/02/2023.
//

import Alamofire
import Foundation

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


