//
//  SavedPhotosViewController.swift
//  Persistence-Lab
//
//  Created by Anthony Gonzalez on 9/30/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class SavedPhotosViewController: UIViewController {
    
    @IBOutlet weak var savedPhotoCollectionView: UICollectionView!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var savedPhotos = [PixabayPhoto]() {
        didSet {
            savedPhotoCollectionView.reloadData()
        }
    }
    
    func loadData(){
        do {
            savedPhotos = try PixabayPhotoPersistenceHelper.manager.getPhoto()
        } catch {
            print(error)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        savedPhotoCollectionView.allowsMultipleSelection = editing
        let indexPaths = savedPhotoCollectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = savedPhotoCollectionView.cellForItem(at: indexPath) as! PixabayCollectionViewCell
            cell.isInEditingMode = editing
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }
}

extension SavedPhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let specificPhoto = savedPhotos[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedPhotoCell", for: indexPath) as! PixabayCollectionViewCell
        
        cell.configureCell(from: specificPhoto)
        cell.isInEditingMode = isEditing
        return cell
    }
}

extension SavedPhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 411  , height: 300)
    }
}

extension SavedPhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !isEditing {
            deleteButton.isEnabled = false
        } else {
            deleteButton.isEnabled = true
        }
    }


func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    if let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.count == 0 {
        deleteButton.isEnabled = false
    }
}
//        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//
//        let detailVC = mainStoryBoard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
//
//        let specificPhoto = savedPhotos[indexPath.row]
//
//        detailVC.currentPixabayPhoto = specificPhoto
//
//
//        self.navigationController?
//            .pushViewController(detailVC, animated: true)
}

