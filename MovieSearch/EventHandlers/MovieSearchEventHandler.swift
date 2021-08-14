//
//  MovieSearchEventHandler.swift
//  MovieSearch
//
//  Created by Lyle Jover on 8/14/21.
//

import Foundation

protocol MovieSearchEventHandlerDelegate: AnyObject {
    func didUpdateMovies()
}

class MovieSearchEventHandler {
    
    //MARK: Enums
    enum MovieEvent {
        case searchMovie(String)
    }
    
    //MARK: Public Properties
    var dataSource: MovieSearchDataSourceType
    
    //MARK: Private Properties
    private let requestHandler: MovieRequestHandlerType
    private weak var delegate: MovieSearchEventHandlerDelegate?
    
    //MARK: Lifecycle
    init(delegate: MovieSearchEventHandlerDelegate,
         dataSource: MovieSearchDataSourceType = MovieSearchDataSource(),
         requestHandler: MovieRequestHandlerType = MovieRequestHandler()) {
        self.requestHandler = requestHandler
        self.delegate = delegate
        self.dataSource = dataSource
    }
    
    //MARK: Public methods
    func handle(_ event: MovieEvent) {
        switch event {
        case .searchMovie(let searchString):
            searchMovie(searchString)
        }
    }
    
    //MARK: Private methods
    private func searchMovie(_ searchString: String) {
        guard !searchString.isEmpty
        else {
            dataSource.movies = []
            self.delegate?.didUpdateMovies()
            return
        }
        requestHandler.getMovies(for: searchString) { result in
            switch result {
            case .success(let movies):
                self.dataSource.movies = movies
                self.delegate?.didUpdateMovies()
            case .failure(_):
                return
            }
        }
    }
}
