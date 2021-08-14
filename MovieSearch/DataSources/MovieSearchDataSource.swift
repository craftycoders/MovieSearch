//
//  MovieSearchDataSource.swift
//  MovieSearch
//
//  Created by Lyle Jover on 8/14/21.
//

import Foundation
import UIKit

protocol MovieSearchDataSourceType {
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    var movies: [Movie] { get set }
}

class MovieSearchDataSource: MovieSearchDataSourceType {
    var movies: [Movie] = []
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return movies.count
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        cell.configure(movie)
        return cell
    }
}
