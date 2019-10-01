//
//  DetailViewController.swift
//  Persistence-Lab
//
//  Created by Anthony Gonzalez on 9/30/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var currentPixabayPhoto: PixabayPhoto!
    
    @IBOutlet weak var pixabayImage: UIImageView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func SaveButtonPressed(_ sender: UIButton) {
        let savedPhoto = PixabayPhoto(webformatURL: currentPixabayPhoto.webformatURL, largeImageURL: currentPixabayPhoto.largeImageURL)
        DispatchQueue.global(qos: .utility).async {
          try? PixabayPhotoPersistenceHelper.manager.save(newPhoto: savedPhoto)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func loadImage() {
        spinner.startAnimating()
        spinner.isHidden = false
        ImageHelper.shared.getImage(urlStr: currentPixabayPhoto.largeImageURL) { (result) in
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    
}
