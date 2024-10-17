//
//  ListRowView.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import Kingfisher
import SwiftUI
import UIKit

struct ListRowView: View {

    enum Constants {
        static let population = "Population:"
    }

    let populationNation: PopulationNationModel
    @State private var isAnimating = true

    init(
        populationNation: PopulationNationModel,
        isAnimating: Bool = true
    ) {
        self.populationNation = populationNation
        self.isAnimating = isAnimating
    }

    var body: some View {
        HStack(spacing: 24.0) {
            VStack(alignment: .leading, spacing: 4.0) {
                Text(populationNation.nation)
                    .font(.headline)
                Text(populationNation.year)
                    .font(.footnote)
                Text(Constants.population)
                        .font(.subheadline)
                Text(String(populationNation.population))
                        .font(.caption)
                        .foregroundColor(.secondary)
            }
            Spacer()
        }
    }

}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        Spacer()
        ListRowView(populationNation: TestData.populationNation)
        .previewLayout(.fixed(width: 200, height: 200))
    }
}
