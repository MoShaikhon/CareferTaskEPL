//
//  ContentView.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 15/04/2023.
//

import SwiftUI

struct EplGamesView: View {
    @StateObject var viewModel: EplGamesViewModel
    var body: some View {
        VStack{
            ControlGroup {
                Button("All games"){
                    viewModel.toggleToAllGames()
                }
                .font(.title)
                .padding()
                Button("Favorites"){
                    viewModel.toggleToFavorites()
                }
            }
            List {
                ForEach($viewModel.eplGames, id: \.date) { $eplGame in
                    Section {
                        Text(eplGame.date)
                        ForEach($eplGame.datedGames){ game in
                            EplGameRow(game: game)
                                .onLongPressGesture{
                                    viewModel.addFavoriteEplGame(game: game.wrappedValue)
                                }
                        }
                    }
                }
            }.task{
                await viewModel.getEplGames()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EplGamesView(viewModel: EplGamesViewModel(interactor: EplGamesInteractor(repo: LeagueGamesRepository(provider: LeagueGamesProvider()))))
    }
}
