//
//  GridView.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import SwiftUI
import TagCloud

struct GridView: View {

    enum Constants {
        static let title = "State"
        static let orderIconName = "arrow.up.arrow.down.circle"
    }

    @ObservedObject private(set) var viewModel: GridViewModel

    private let columns = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]

    init(viewModel: GridViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            gridView
                .navigationBarTitle(Constants.title)
                .navigationBarItems(trailing: yearDropDownButton)
                .navigationBarItems(leading: itemOrderButton)
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

    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.populationStateListFormated) { state in
                    GridElementView(populationState: state)
                }
            }
            .padding(.horizontal)
        }
    }

    private var yearDropDownButton: some View {
        DropDownMenu(
            years: viewModel.yearList,
            selectedYear: $viewModel.selectedYear
        )
    }
}

// MARK: Preview

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(
            viewModel: GridViewModel(
                populationStateList: [TestData.populationState],
                apiService: DataUSAAPIService()
            )
        )
    }
}
