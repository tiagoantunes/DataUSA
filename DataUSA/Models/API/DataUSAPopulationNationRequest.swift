//
//  DataUSAPopulationNationRequest.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import Foundation

struct DataUSAPopulationNationRequest: APIRequestType {
    typealias ModelType = DataUSAPopulationNationResponse

    private enum Constants {
        static let drilldowns = "Nation"
        static let measures = "Population"
    }

    var baseURL: String {
        Environment.dataUSAServerUrl
    }

    var path: String? {
        "/data"
    }

    var method: HTTPMethod {
        .get
    }

    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "drilldowns", value: Constants.drilldowns),
            URLQueryItem(name: "measures", value: Constants.measures)
        ]
    }
}
