//
//  TestData.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import Foundation

enum TestData {
    static var populationStateResponse: DataUSAPopulationStateResponse? {
        do {
            guard let url = Bundle.main.url(forResource: "datausa_population_state", withExtension: "json") else {
                return nil
            }
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(DataUSAPopulationStateResponse.self, from: data)
        } catch {
            return nil
        }
    }

    static var populationNationResponse: DataUSAPopulationNationResponse? {
        do {
            guard let url = Bundle.main.url(forResource: "datausa_population_nation", withExtension: "json") else {
                return nil
            }
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(DataUSAPopulationNationResponse.self, from: data)
        } catch {
            return nil
        }
    }

    static var populationState: PopulationStateModel {
        return populationStateResponse!.data.first!
    }

    static var populationNation: PopulationNationModel {
        return populationNationResponse!.data.first!
    }
}
