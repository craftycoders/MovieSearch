//
//  ImageView+Extension.swift
//  MovieSearch
//
//  Created by Lyle Jover on 8/14/21.
//

import Foundation
import UIKit

//Makes this mockable
protocol DownloadImageProtocol {
    func downloadImage(for imageURL: String, key: String)
}

extension UIImageView: DownloadImageProtocol {
    func downloadImage(for imageURL: String, key: String) {
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            let compressedImage = UIImage(data: image.jpegData(compressionQuality: 0.1)!) ?? UIImage(named: "PosterPlaceholder")!
            ImageCache.shared.save(image: compressedImage, for: NSString(string: key))
            DispatchQueue.main.async() { [weak self] in
                self?.image = compressedImage
            }
        }.resume()
    }
}
