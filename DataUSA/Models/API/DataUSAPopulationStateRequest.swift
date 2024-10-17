//
//  DataUSAPopulationStateRequest.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import Foundation

struct DataUSAPopulationStateRequest: APIRequestType {
    typealias ModelType = DataUSAPopulationStateResponse

    private enum Constants {
        static let drilldowns = "State"
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
