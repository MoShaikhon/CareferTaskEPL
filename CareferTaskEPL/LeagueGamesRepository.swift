//
//  LeagueGamesRepository.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 17/04/2023.
//

import Foundation

protocol LeagueGamesReposing {
    func fetchGames(leagueCode: LeagueCode) async throws -> LeagueGamesData
    func fetchFavoriteGames()-> EplGamesPresentationData
    func addFavoriteGame(game: EplGamePresentationData)
}

class LeagueGamesRepository: LeagueGamesReposing{

    let provider: LeagueGamesProviding
    init(provider: LeagueGamesProviding) {
        self.provider = provider
    }
    func fetchGames(leagueCode: LeagueCode) async throws -> LeagueGamesData{
        let response = try await withCheckedThrowingContinuation ({continuation in
            provider.getLeagueGames(ofLeagueCode: leagueCode.rawValue, responseType: LeagueGamesData.self) { (results) in
                switch results {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
        
        return response
    }
    func fetchFavoriteGames() -> EplGamesPresentationData {
        []
    }
    
    func addFavoriteGame(game: EplGamePresentationData) {
        
    }
    
}
