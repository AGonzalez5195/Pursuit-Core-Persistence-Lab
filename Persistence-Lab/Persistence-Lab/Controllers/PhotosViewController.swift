//
//  ViewController.swift
//  Persistence-Lab
//
//  Created by Anthony Gonzalez on 9/30/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var photos = [PixabayPhoto]() {
        didSet {
            self.photoCollectionView.reloadData()
        }
    }
    
    var searchString = "" {
        didSet {
            let userEnteredString = searchString.replacingOccurrences(of: " ", with: "+")
            loadData(newStr: userEnteredString)
        }
    }
    
    private func loadData(newStr: String) {
        PixabayAPIClient.manager.getPhotos(searchQuery: newStr) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let photosFromOnline):
                    self.photos = photosFromOnline
                    dump(photosFromOnline)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(newStr: searchString)
        
    }
}


extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let specificPhoto = photos[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pixabayCell", for: indexPath) as! PixabayCollectionViewCell
        
        cell.configureCell(from: specificPhoto)
        
        return cell
    }
}



extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 411  , height: 300)
    }
}


extension PhotosViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)

        let detailVC = mainStoryBoard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController

        let specificPhoto = photos[indexPath.row]

        detailVC.currentPixabayPhoto = specificPhoto

        self.navigationController?
            .pushViewController(detailVC, animated: true)
    }
}
