//
//  MovieCell.swift
//  MovieSearch
//
//  Created by Lyle Jover on 8/14/21.
//

import UIKit

class MovieCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    //MARK: Public Properties
    static let reuseIdentifier = "MovieCell"
    
    //MARK: Private Properties
    private var viewModel: MovieSearchViewModel?
        
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.image = UIImage(named: "PosterPlaceholder")
    }
    
    //MARK: Public Methods
    func configure(_ movie: Movie) {
        viewModel = MovieSearchViewModel(movie)
        updateView()
    }
    
    //MARK: Private Methods
    private func updateView() {
        titleLabel.text = viewModel?.title ?? ""
        descriptionLabel.text = viewModel?.description ?? ""
        loadImage()
    }
    
    private func loadImage() {
        guard let posterPath = viewModel?.imagePathName else { return }
        //Use cached image if available
        if let image = ImageCache.shared.getImage(for: NSString(string: posterPath)) {
            posterImageView.image = image
        } else {
            posterImageView.downloadImage(for: viewModel?.imageURL ?? "", key: posterPath)
        }
    }
}

