//
//  LeagueGamesProvider.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 17/04/2023.
//

import Moya

protocol LeagueGamesProviding{
    func getLeagueGames<T: Codable>(ofLeagueCode: String, responseType: T.Type ,completion: @escaping (Result<T, Error>) -> Void)
}

class LeagueGamesProvider: LeagueGamesProviding{
    
    let provider = MoyaProvider<LeagueGamesServices>()
    
    func getLeagueGames<T>(ofLeagueCode: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        provider.request(.games(leagueCode: ofLeagueCode)) { result in
            switch result {
            case .success(let response):
                do {
                    let leagueGames = try JSONDecoder().decode(responseType, from: response.data)
                    completion(.success(leagueGames))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

