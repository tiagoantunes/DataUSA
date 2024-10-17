//
//  Environment.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import Foundation

public enum Environment {
    enum Keys {
        static let dataUSAServerUrl = "DATAUSA_API_SERVER_URL"
        static let dataUSAApiKey = "DATAUSA_API_KEY"
    }

    private static let infoDictionary: [String: Any] = {
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError("plist not exist")
        }
        return dictionary
    }()

    // MARK: - Plist values
    static let dataUSAServerUrl: String = {
        guard let serverURLstring = infoDictionary[Keys.dataUSAServerUrl] as? String else {
            fatalError("Server url dont exist for this environment")
        }
        return serverURLstring
    }()

    static let dataUSAApiKey: String = {
        guard let apiKey = infoDictionary[Keys.dataUSAApiKey] as? String else {
            fatalError("Api key dont exist for this environment")
        }
        return apiKey
    }()
}
