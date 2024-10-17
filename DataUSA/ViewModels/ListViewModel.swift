//
//  ListViewModel.swift
//  DataUSA
//
//  Created by Tiago Antunes on 15/10/2024.
//

import Combine
import Foundation
import SwiftUI

final class ListViewModel: ObservableObject {

    private var cancellable: Set<AnyCancellable>
    private let apiService: APIServiceType

    @Published var isSorted = false
    @Published var populationNationList: [PopulationNationModel] = []
    @Published var dataIsLoading = false
    @Published var isErrorShown = false
    @Published var errorMessage = ""

    init(
        populationNationList: [PopulationNationModel] = [],
        apiService: APIServiceType
    ) {
        self.populationNationList = populationNationList
        self.cancellable = Set<AnyCancellable>()
        self.apiService = apiService
    }

    var populationNationListFormated: [PopulationNationModel] {
        if isSorted {
            return populationNationList.sorted { $0.population < $1.population }
        } else {
            return populationNationList
        }
    }

    var yearList: [String] {
        let yearList = populationNationList.compactMap(\.year)
        return Array(Set(yearList)).sorted()
    }

    func changeSortMode() {
        isSorted.toggle()
    }
}

extension ListViewModel {

    func requestItems() {
        dataIsLoading = true
        self.apiService.call(from: DataUSAPopulationNationRequest())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                if case let .failure(error) = result {
                    self?.errorMessage = error.localizedDescription
                    self?.isErrorShown = true
                    self?.dataIsLoading = false
                }
            }, receiveValue: { [weak self] response in
                self?.populationNationList = response.data
                self?.dataIsLoading = false
            })
            .store(in: &cancellable)
    }
}
