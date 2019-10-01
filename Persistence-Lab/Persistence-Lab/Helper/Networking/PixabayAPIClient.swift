//
//  PixabayAPIClient.swift
//  Persistence-Lab
//
//  Created by Anthony Gonzalez on 9/30/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation

struct PixabayAPIClient {
    
    // MARK: - Static Properties
    
    static let manager = PixabayAPIClient()
    
    // MARK: - Instance Methods
    
    func getPhotos(searchQuery: String, completionHandler: @escaping (Result<[PixabayPhoto], AppError>) -> ())  {
        let url = URL(string: "https://pixabay.com/api/?key=13797080-8e8080b7a8b86fc40c433976e&q=\(searchQuery)")!
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let photoInfo = try PixabayWrapper.decodePhotosFromData(from: data)
                    completionHandler(.success(photoInfo))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
                
            }
        }
    }
    
    
    // MARK: - Private Properties and Initializers
    private var photosURL: URL {
        guard let url = URL(string: "https://pixabay.com/api/?key=13797080-8e8080b7a8b86fc40c433976e&q") else {
            fatalError("Error: Invalid URL")
        }
        return url
    }
    
    private init() {}
}
