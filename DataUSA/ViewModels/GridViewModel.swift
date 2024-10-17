//
//  GridViewModel.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import Combine
import Foundation
import SwiftUI

final class GridViewModel: ObservableObject {

    private var cancellable: Set<AnyCancellable>
    private let apiService: APIServiceType

    @Published var selectedYear: String = ""
    @Published var isSorted = false
    @Published var populationStateList: [PopulationStateModel] = []
    @Published var dataIsLoading = false
    @Published var isErrorShown = false
    @Published var errorMessage = ""

    init(
        populationStateList: [PopulationStateModel] = [],
        apiService: APIServiceType
    ) {
        self.populationStateList = populationStateList
        self.cancellable = Set<AnyCancellable>()
        self.apiService = apiService
    }

    var populationStateListFormated: [PopulationStateModel] {
        let population = populationStateList.filter { state in
            state.year == selectedYear
        }

        if isSorted {
            return population.sorted { $0.population < $1.population }
        } else {
            return population
        }
    }

    var yearList: [String] {
        let yearList = populationStateList.compactMap(\.year)
        return Array(Set(yearList)).sorted()
    }

    func changeSortMode() {
        isSorted.toggle()
    }
}

extension GridViewModel {

    func requestItems() {
        dataIsLoading = true
        self.apiService.call(from: DataUSAPopulationStateRequest())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                if case let .failure(error) = result {
                    self?.errorMessage = error.localizedDescription
                    self?.isErrorShown = true
                    self?.dataIsLoading = false
                }
            }, receiveValue: { [weak self] response in
                self?.populationStateList = response.data
                self?.selectedYear = self?.yearList.first ?? ""
                self?.dataIsLoading = false
            })
            .store(in: &cancellable)
    }
}
