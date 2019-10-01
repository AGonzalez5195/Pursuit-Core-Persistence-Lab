//
//  PixabayCollectionViewCell.swift
//  Persistence-Lab
//
//  Created by Anthony Gonzalez on 9/30/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class PixabayCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pixabayImage: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func configureCell(from photo: PixabayPhoto) {
        spinner.startAnimating()
        spinner.isHidden = false
        ImageHelper.shared.getImage(urlStr: photo.webformatURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    self.pixabayImage.image = imageFromOnline
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                }
            }
        }
    }
}

