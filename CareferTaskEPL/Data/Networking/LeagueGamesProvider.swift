//
//  LeagueGamesProvider.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 17/04/2023.
//

import Moya

protocol LeagueGamesProviding{
    func getLeagueGames<T: Codable>(ofLeagueCode: String, responseType: T.Type ,completion: @escaping (Result<T, Error>) -> Void)
    func fetchFavoriteGames()-> EplGamesPresentationData
    func addFavoriteGame(game: EplGamePresentationData)
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
    func fetchFavoriteGames() -> EplGamesPresentationData {
        return retrieveCodable(for: Keys.favorites()) ?? []
    }
    
    func addFavoriteGame(game: EplGamePresentationData) {
      var favorites = fetchFavoriteGames()
        favorites.append(game)
        storeCodable(favorites, key: Keys.favorites())
    }
    private func storeCodable<T: Codable>(_ object: T, key: String) {
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.set(data, forKey: key)
        } catch let error {
            debugPrint("Error encoding: \(error)")
        }
    }
    
    private func retrieveCodable<T: Codable>(for key: String) -> T? {
        do {
            guard let data = UserDefaults.standard.data(forKey: key) else {
                return nil
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            debugPrint("Error decoding: \(error)")
            return nil
        }
    }
}

