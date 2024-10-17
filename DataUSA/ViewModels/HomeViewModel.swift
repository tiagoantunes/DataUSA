//
//  HomeViewModel.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import Combine
import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {

    enum PopulationByType: String {
        case state = "State"
        case nation = "Nation"
    }

    private let apiService: APIServiceType
    private var output: Output?

    struct Output {
        var didSelectItem: (_ type: PopulationByType) -> Void
    }

    init(
        apiService: APIServiceType,
        output: Output?
    ) {
        self.apiService = apiService
        self.output = output
    }
    

    var optionList: [PopulationByType] {
        [
            PopulationByType.state,
            PopulationByType.nation
        ]
    }

    func didSelectItem(type: PopulationByType) {
        output?.didSelectItem(type)
    }
}
