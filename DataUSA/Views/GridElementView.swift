//
//  GridElementView.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import Kingfisher
import SwiftUI
import UIKit

struct GridElementView: View {

    enum Constants {
        static let population = "Population:"
    }

    let populationState: PopulationStateModel
    @State private var isAnimating = true

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text(populationState.state)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                Text(Constants.population)
                    .font(.subheadline)
                Text(String(populationState.population))
                    .font(.caption)
                    .foregroundColor(.secondary)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct GridElementView_Previews: PreviewProvider {
    static var previews: some View {
        Spacer()
        GridElementView(
            populationState: TestData.populationState
        )
    }
}
