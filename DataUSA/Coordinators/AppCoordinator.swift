//
//  AppCoordinator.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import SwiftUI

enum Page {
    case home
    case grid
    case list
}

final class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func gotoHomePage() {
        path.removeLast(path.count)
    }

    func goToGridPage() {
        path.append(Page.grid)
    }

    func goToListPage() {
        path.append(Page.list)
    }

    func goBack() {
        path.removeLast()
    }

    // MARK: View Creation Methods

    @ViewBuilder
    func view(page: Page) -> some View {
        switch page {
        case .home:
            homeView()
        case .grid:
            gridView()
        case .list:
            listView()
        }
    }

    func gridView() -> some View {
        let viewModel = GridViewModel(
            apiService: DataUSAAPIService()
        )
        return GridView(viewModel: viewModel)
    }

    func listView() -> some View {
        let viewModel = ListViewModel(
            apiService: DataUSAAPIService()
        )
        return ListView(viewModel: viewModel)
    }

    func homeView() -> some View {
        let viewModel = HomeViewModel(
            apiService: DataUSAAPIService(),
            output: .init(
                didSelectItem: { [weak self] type in
                    switch type {
                    case .nation:
                        self?.goToListPage()
                    case .state:
                        self?.goToGridPage()
                    }
                }
            )
        )
        return HomeView(viewModel: viewModel)
    }
}
