//
//  LeagueGamesServices.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 17/04/2023.
//

import Moya

enum LeagueGamesServices {
    case games(leagueCode: String)
}

extension LeagueGamesServices: TargetType {
    
    var baseURL: URL { URL(string: "https://api.football-data.org")! }

    
    var path: String {
        switch self {
        case .games(let leagueCode):
            return "/v4/competitions/\(leagueCode)/matches"
        }
    }
    
    var method: Method {
        .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["X-Auth-Token": "bf1b978edc0843f09ed013d708b7a3f8"]
    }
    
}
