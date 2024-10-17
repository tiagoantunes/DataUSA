//
//  ListViewModelTests.swift
//  DataUSATests
//
//  Created by Tiago Antunes on 13/10/2024.
//

import Combine
import Foundation
import XCTest
@testable import DataUSA

class ListViewModelTests: XCTestCase {

    func test_showNationList() {
        let mockDataUSAAPIService = MockDataUSAAPIService()

        mockDataUSAAPIService.stub(for: DataUSAPopulationNationRequest.self, response: { _ in
            Result.Publisher(
                DataUSAPopulationNationResponse(
                    data: [
                        PopulationNationModel(
                            idNation: "",
                            nation: "",
                            idYear: 2024,
                            year: "2024",
                            population: 1,
                            slugNation: ""
                        )
                    ]
                )
            ).eraseToAnyPublisher()
        })

        let viewModel = ListViewModel(
            apiService: mockDataUSAAPIService
        )

        XCTAssertTrue(viewModel.populationNationList.isEmpty)
    }

    func test_emptyListForEmptyJson() {
        let mockDataUSAAPIService = MockDataUSAAPIService()

        mockDataUSAAPIService.stub(for: DataUSAPopulationNationRequest.self, response: { _ in
            Result.Publisher(
                DataUSAPopulationNationResponse(
                    data: []
                )
            ).eraseToAnyPublisher()
        })

        let viewModel = ListViewModel(
            apiService: mockDataUSAAPIService
        )

        XCTAssertTrue(!viewModel.populationNationList.isEmpty)
    }

    func test_throwParseErrorForMalformedJson() {
        let mockDataUSAAPIService = MockDataUSAAPIService()

        mockDataUSAAPIService.stub(for: DataUSAPopulationNationRequest.self, response: { _ in
            Result.Publisher(
                APIServiceError.parseError
            ).eraseToAnyPublisher()
        })

        let viewModel = ListViewModel(
            apiService: mockDataUSAAPIService
        )

        XCTAssertEqual(viewModel.errorMessage, APIServiceError.parseError.errorDescription)
    }
}
