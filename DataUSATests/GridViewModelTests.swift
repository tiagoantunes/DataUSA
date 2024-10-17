//
//  GridViewModelTests.swift
//  DataUSATests
//
//  Created by Tiago Antunes on 13/10/2024.
//

import Combine
import Foundation
import XCTest
@testable import DataUSA

class GridViewModelTests: XCTestCase {

    func test_showStateList() {
        let mockDataUSAAPIService = MockDataUSAAPIService()

        mockDataUSAAPIService.stub(for: DataUSAPopulationStateRequest.self, response: { _ in
            Result.Publisher(
                DataUSAPopulationStateResponse(
                    data: [
                        PopulationStateModel(
                            idState: "",
                            state: "",
                            idYear: 2024,
                            year: "2024",
                            population: 1,
                            slugState: ""
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

        mockDataUSAAPIService.stub(for: DataUSAPopulationStateRequest.self, response: { _ in
            Result.Publisher(
                DataUSAPopulationStateResponse(
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

        mockDataUSAAPIService.stub(for: DataUSAPopulationStateRequest.self, response: { _ in
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
