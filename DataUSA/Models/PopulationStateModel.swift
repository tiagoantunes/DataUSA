//
//  PopulationStateModel.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import Foundation

struct PopulationStateModel: Codable, Identifiable {
    let id: String = UUID().uuidString
    let idState: String
    let state: String
    let idYear: Int
    let year: String
    let population: Int
    let slugState: String

    public enum CodingKeys: String, CodingKey {
        case idState = "ID State"
        case state = "State"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugState = "Slug State"
    }
}
