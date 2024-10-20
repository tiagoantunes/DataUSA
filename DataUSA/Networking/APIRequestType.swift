//
//  APIRequestType.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import Foundation

protocol APIRequestType {
    associatedtype ModelType: Decodable

    var baseURL: String { get }
    var path: String? { get }
    var queryItems: [URLQueryItem]? { get }
    var cachePolicy: URLRequest.CachePolicy? { get }
    var timeoutInterval: TimeInterval? { get }
    var headers: [String: String]? { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
}

extension APIRequestType {

    var cachePolicy: URLRequest.CachePolicy? {
        return .useProtocolCachePolicy
    }

    var timeoutInterval: TimeInterval? {
        return 20.0
    }

    var headers: [String: String]? {
        ["accept": "application/json"]
    }

    var body: Data? {
        return nil
    }
}

extension APIRequestType {

    func buildRequest() throws -> URLRequest {
        guard let url = pathAppendedURL else {
            throw APIServiceError.invalidURL
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = method.name
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }

    private var pathAppendedURL: URL? {
        var url = URL(string: "https://\(baseURL)")
        url?.appendPathComponent(path ?? "")
        return url
    }
}
