//
//  CareferTaskEPLApp.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 15/04/2023.
//

import SwiftUI

@main
struct CareferTaskEPLApp: App {
    var body: some Scene {
        WindowGroup {
            EplGamesView(viewModel: EplGamesViewModel(interactor: EplGamesInteractor(repo: LeagueGamesRepository(provider: LeagueGamesProvider()))))
        }
    }
}
