//
//  URLs.swift
//  Sports-App
//
//  Created by MESHO on 09/02/2023.
//

import Foundation

struct URLService {
    var endPoint: String = ""
    var url: String{
        return "https://apiv2.allsportsapi.com/\(endPoint)/?met=Leagues&APIkey=c5ebd307b70cdd257579522744048f245836e9714d8a72205ec5cad867dd165a"
    }
    
}

