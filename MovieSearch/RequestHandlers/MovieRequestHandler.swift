//
//  MovieRequestHandler.swift
//  MovieSearch
//
//  Created by Lyle Jover on 8/14/21.
//

import Foundation
import UIKit

//Makes this mockable
protocol MovieRequestHandlerType {
    func getMovies(for searchTerm: String, _ completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieRequestHandler: MovieRequestHandlerType {
    //MARK: Enums
    private enum Configuration {
        static let apiKey = "2a61185ef6a27f400fd92820ad9e8537"
        static var searchEndpointURL = URLComponents(string: "https://api.themoviedb.org/3/search/movie")!
    }
    
    //MARK: Private Properties
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?

    //MARK: Public Methods
    func getMovies(for searchTerm: String, _ completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard !searchTerm.isEmpty
        else {
            completion(.failure(RequestError.emptyResponse))
            return
        }
        //Cancels previous as they type
        dataTask?.cancel()
        Configuration.searchEndpointURL.query = "api_key=\(Configuration.apiKey)&query=\(searchTerm)"
        guard let url = Configuration.searchEndpointURL.url else { return }
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            if let error = error {
                completion(.failure(error))
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                do {
                    let movies = try JSONDecoder().decode(MovieSearchResponse.self, from: data)
                    completion(.success(movies.results))
                } catch {
                    completion(.failure(RequestError.parsingError))
                }
            }
        }
        dataTask?.resume()
    }
}

extension MovieRequestHandler {
    private struct MovieSearchResponse: Decodable {
        let results: [Movie]
    }
}
