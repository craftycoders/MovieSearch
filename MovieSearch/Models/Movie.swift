//
//  Movie.swift
//  MovieSearch
//
//  Created by Lyle Jover on 8/14/21.
//

import Foundation
import UIKit

class Movie: Decodable {
    //MARK: Properties
    let title: String
    let description: String
    let imagePath: String
    
    //MARK: Enums
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case description = "overview"
        case imagePath = "poster_path"
    }
}
