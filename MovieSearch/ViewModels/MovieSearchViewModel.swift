//
//  MovieSearchViewModel.swift
//  MovieSearch
//
//  Created by Lyle Jover on 8/14/21.
//

import Foundation
import UIKit

class MovieSearchViewModel {
    
    //MARK: Enum
    private enum Configuration {
        static let imageURL = "https://image.tmdb.org/t/p/w600_and_h900_bestv2/"
    }
    
    //MARK: Public Properties
    var title: String {
        return movie.title.capitalized
    }
    
    var description: String {
        return movie.description
    }
    
    var imagePathName: String {
        return movie.imagePath
    }
    
    var imageURL: String {
        return "\(Configuration.imageURL)\(imagePathName)"
    }
    
    //MARK: Private Properties
    private let movie: Movie
    
    //MARK: Lifecycle
    init(_ movie: Movie) {
        self.movie = movie
    }
}
