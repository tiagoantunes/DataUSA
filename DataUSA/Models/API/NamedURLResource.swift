//
//  NamedURLResource.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import Foundation

struct NamedURLResource: Decodable, Hashable {
    let name: String
    let url: URL?
}
