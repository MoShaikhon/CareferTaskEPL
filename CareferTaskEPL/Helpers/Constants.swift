//
//  Constants.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 17/04/2023.
//

import Foundation

let BASE_URL = "https://api.football-data.org"

enum LeagueCode: String{
    case epl = "PL"
}
enum Keys: String{
    case favorites = "favorites"
    func callAsFunction() -> String {
        return self.rawValue
    }
}
