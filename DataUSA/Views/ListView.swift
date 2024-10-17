//
//  ListView.swift
//  DataUSA
//
//  Created by Tiago Antunes on 15/10/2024.
//

import SwiftUI
import TagCloud

struct ListView: View {

    enum Constants {
        static let title = "Nation"
        static let orderIconName = "arrow.up.arrow.down.circle"
    }

    @ObservedObject private(set) var viewModel: ListViewModel

    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            listView
                .navigationBarTitle(Constants.title)
                .navigationBarItems(trailing: itemOrderButton)
                .onAppear {
                    viewModel.requestItems()
                }

            if viewModel.dataIsLoading {
                ProgressView()
            }

            if viewModel.isErrorShown {
                Text(viewModel.errorMessage)
            }
        }
    }

    private var itemOrderButton: some View {
        Button(action: {
            viewModel.changeSortMode()
        }) {
            Image(systemName: Constants.orderIconName)
                .imageScale(.large)
                .tint(viewModel.isSorted ? .gray : .blue)
        }
    }

    private var listView: some View {
        List(viewModel.populationNationListFormated) { nation in
            ListRowView(populationNation: nation)
        }
    }
}

// MARK: Preview

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(
            viewModel: ListViewModel(
                populationNationList: [TestData.populationNation],
                apiService: DataUSAAPIService()
            )
        )
    }
}

