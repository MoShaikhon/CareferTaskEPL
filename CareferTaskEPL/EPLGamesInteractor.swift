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
    func addFavoriteGame(id: Int)
}
protocol Adapting{
    associatedtype FromType
    associatedtype ToType
    func adapt(from data: FromType) -> ToType?
}
class EplGamesInteractor: EplGamesInteracting {
    func addFavoriteGame(id: Int) {
//        guard let favoriteGame = eplGamesData?.matches.first(where: {$0.id == id}) else {return}
//        favoritedEplGames == nil ? favoritedEplGames = [favoriteGame] : favoritedEplGames?.append(favoriteGame)
//        repo.addFavoriteGame(favoriteGame)
    
    }
    
    
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
        } catch{ print(error) }
        return eplGamesDomainData
    }
    func getPresentAndFutureGames(from league: LeagueGamesData) -> [Match] {
        return league.matches.filter({date(from: $0.utcDate)! >= Date()})
    }


}
extension EplGamesInteractor: Adapting {
    typealias ToType = LeagueDatedGamesDomainData
    typealias FromType = LeagueGamesData
    
    func adapt(from data: LeagueGamesData) -> LeagueDatedGamesDomainData? {
        LeagueDatedGamesDomainData(datedGames: Dictionary(grouping: getPresentAndFutureGames(from: data), by: {date(from: $0.utcDate)!}))
//
//        let keys = getPresentAndFutureGames(from: data).map({$0.utcDate})
//        var adaptedData: LeagueDatedGamesDomainData?
//        keys.forEach{key in
//            adaptedData?.datedGames[key] = data.matches.filter({$0.utcDate == key})
//        }
//        return adaptedData
    }
}

func date(from dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter.date(from: dateString)
}
