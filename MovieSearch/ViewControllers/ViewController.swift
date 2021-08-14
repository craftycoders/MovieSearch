//
//  ViewController.swift
//  MovieSearch
//
//  Created by Lyle Jover on 8/14/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    private var eventHandler: MovieSearchEventHandler?

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableview()
        eventHandler = MovieSearchEventHandler(delegate: self)
        searchBar.delegate = self
    }
    
    //MARK: Private Methods
    private func configureTableview(){
        tableView.register(UINib(nibName: MovieCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MovieCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120.0
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        eventHandler?.handle(.searchMovie(searchText))
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventHandler?.dataSource.numberOfSections() ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventHandler?.dataSource.numberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return eventHandler?.dataSource.cellForRowAt(tableView, indexPath: indexPath) ?? UITableViewCell()
    }
}

//MARK: MovieSearchEventHandlerDelegate
extension ViewController: MovieSearchEventHandlerDelegate {
    func didUpdateMovies() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
