//
//  EPLGamesInteractor.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 17/04/2023.
//

import Foundation
import Combine

protocol EplGamesInteracting{
    var eplGamesDomainPublisher: Published<LeagueDatedGamesDomainData?>.Publisher { get }
    func loadGames() async-> LeagueDatedGamesDomainData?
    func getFavoriteGames()-> EplGamesPresentationData
    func addFavoriteGame(game: EplGamePresentationData)
}
protocol Adapting{
    associatedtype FromType
    associatedtype ToType
    func adapt(from data: FromType) -> ToType?
}
class EplGamesInteractor: EplGamesInteracting {
    
    let repo: LeagueGamesReposing
    var eplGamesData: LeagueGamesData?
    var favoritedEplGames: LeagueDatedGamesDomainData?
    @Published var eplGamesDomainData: LeagueDatedGamesDomainData?
    var eplGamesDomainPublisher: Published<LeagueDatedGamesDomainData?>.Publisher{
        $eplGamesDomainData
    }
    
    init(repo: LeagueGamesReposing) {
        self.repo = repo
    }
    func loadGames()async -> LeagueDatedGamesDomainData?  {
        do {
            eplGamesData = try await repo.fetchGames(leagueCode: .epl)
            eplGamesDomainData = adapt(from: eplGamesData!)
        } catch{ debugPrint(error) } // code smell (no error propagation)
        return eplGamesDomainData
    }
    func getPresentAndFutureGames(from league: LeagueGamesData) -> [Match] {
        return league.matches.filter({date(from: $0.utcDate.formatDate()!)! >= Date()}) // code smell
    }

    func getFavoriteGames() -> EplGamesPresentationData {
        repo.fetchFavoriteGames()
    }
    
    func addFavoriteGame(game: EplGamePresentationData) {
        repo.addFavoriteGame(game: game)
    }

}
extension EplGamesInteractor: Adapting {
    typealias ToType = LeagueDatedGamesDomainData
    typealias FromType = LeagueGamesData
    
    func adapt(from data: LeagueGamesData) -> LeagueDatedGamesDomainData? {
        LeagueDatedGamesDomainData(datedGames: Dictionary(grouping: getPresentAndFutureGames(from: data), by: {date(from: $0.utcDate.formatDate()!)!})) // code smell
    }
}


