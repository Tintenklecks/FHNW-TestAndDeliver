//
//  NetworkService.swift
//  OpenAIImages
//
//  Created by Ingo Boehme on 21.12.22.
//

import Foundation

// MARK: - DataService

protocol DataService {
    func load<T: Decodable>(
        from request: URLRequest,
        convertTo type: T.Type) async throws -> T

    func load<T: Decodable>(
        from request: URLRequest,
        convertTo type: T.Type, handler: @escaping (Result<T, NetworkError>) -> ())
}

// MARK: - NetworkService

class NetworkService: DataService {
    func load<T: Decodable>(
        from request: URLRequest,
        convertTo type: T.Type) async throws -> T
    {
        let (data, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode >= 300
        {
            throw NetworkError.httpError(httpResponse.statusCode)
        }

        let decodedData = try JSONDecoder().decode(T.self, from: data)

        return decodedData
    }

    func load<T: Decodable>(
        from request: URLRequest,
        convertTo type: T.Type, handler:@escaping  (Result<T, NetworkError>) -> ())
    {
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data {
                if let result = try? JSONDecoder().decode(T.self, from: data) {
                    handler(.success(result))
                }
            }
            handler(.failure(.misc("Some Error")))
        }
        .resume()
        
    }
}

// MARK: - MockService

class MockService: DataService {
    func load<T>(from request: URLRequest, convertTo type: T.Type) async throws -> T where T: Decodable {
        guard let fileName = request.url?.lastPathComponent,
              let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json")
        else {
            throw NetworkError.noData
        }
        let data = try Data(contentsOf: fileUrl)
        let decodedData = try JSONDecoder().decode(T.self, from: data)

        return decodedData
    }
    
    func load<T: Decodable>(
        from request: URLRequest,
        convertTo type: T.Type, handler: @escaping (Result<T, NetworkError>) -> ())
    {
        
        guard let fileName = request.url?.lastPathComponent,
              let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json")
        else {
            handler(.failure(NetworkError.noData))
            return
        }

        URLSession.shared.dataTask(with: fileUrl) { data, _, _ in
            if let data {
                if let result = try? JSONDecoder().decode(T.self, from: data) {
                    handler(.success(result))
                }
            }
            handler(.failure(.misc("Some Error")))
        }
        .resume()
    }

}
