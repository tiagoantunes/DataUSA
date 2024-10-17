//
//  HomeView.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import Kingfisher
import SwiftUI

struct HomeView: View {

    enum Constants {
        static let title = "DataUSA"
        static let description = "Filter information by:"
    }

    @ObservedObject private(set) var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Spacer()
            Text(Constants.title)
                .font(.largeTitle)
            Spacer()
            Text(Constants.description)
                .font(.footnote)
                .padding(.bottom)
            HStack(spacing: 20) {
                ForEach(viewModel.optionList, id: \.self) { option in
                    Button(action: {
                        viewModel.didSelectItem(type: option)
                    }) {
                        HStack {
                            Spacer()
                            Text(option.rawValue)
                            Spacer()
                        }
                    }
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .frame(height: 44)
                    .background(Color.black)
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal, 20)
            Spacer()

        }

    }
}

// MARK: - Previews
struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView(
                viewModel: HomeViewModel(
                    apiService: DataUSAAPIService(),
                    output: nil
                )
            )
        }
    }
}
