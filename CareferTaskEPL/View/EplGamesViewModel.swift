//
//  EplGamesViewModel.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 16/04/2023.
//

import Foundation

@MainActor
class EplGamesViewModel: ObservableObject{
    
    @Published var eplGames: EplDatedGamesPresentationData = []
    private var tempEplGames: EplDatedGamesPresentationData = []
    private var favoriteEplGames: EplDatedGamesPresentationData = []
    
    private let interactor: EplGamesInteracting
    init(interactor: EplGamesInteracting) {
        self.interactor = interactor
    }
    func getEplGames() async {
        guard let eplDomainGames = await interactor.loadGames() else {return}
        guard let adaptedGames = adapt(from: eplDomainGames) else {return}
        eplGames = adaptedGames
    }
    func toggleToFavorites(){
        favoriteEplGames = [EplDatedGamePresentationData(date: "", datedGames: interactor.getFavoriteGames())]
        tempEplGames = eplGames
        eplGames = favoriteEplGames
    }
    func toggleToAllGames(){
        eplGames = tempEplGames
    }
    func addFavoriteEplGame(game: EplGamePresentationData){
        interactor.addFavoriteGame(game: game)
    }
}

extension EplGamesViewModel: Adapting{
    func adapt(from data: LeagueDatedGamesDomainData) -> EplDatedGamesPresentationData? {
        let keys = data.datedGames.keys.sorted()
        var adaptedData: EplDatedGamesPresentationData = []
        
        keys.forEach{key in
            guard let games = data.datedGames[key]?.map({EplGamePresentationData(id: $0.id, homeTeamName: $0.homeTeam.shortName, awayTeamName: $0.awayTeam.shortName, homeTeamScore: $0.score.fullTime.home == nil ? "-" : String($0.score.fullTime.home!), awayTeamScore: $0.score.fullTime.away == nil ? "-" : String($0.score.fullTime.away!), shouldShowMatchTimeInsteadOfScore: $0.score.fullTime.home == nil, matchTime: $0.utcDate.getTimeString() ?? "unknown")}) else {return }
            adaptedData.append(EplDatedGamePresentationData(date: key.dateStringFromDate() , datedGames: games))
            
        }
        return adaptedData
    }
    
    typealias FromType = LeagueDatedGamesDomainData
    
    typealias ToType = EplDatedGamesPresentationData
    
    
}

