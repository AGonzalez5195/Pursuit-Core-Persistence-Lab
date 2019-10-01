//
//  Pixabay.swift
//  Persistence-Lab
//
//  Created by Anthony Gonzalez on 9/30/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation

// MARK: - Pixabay
struct PixabayWrapper: Codable {
    let hits: [PixabayPhoto]
    
    static func decodePhotosFromData(from jsonData: Data) throws -> [PixabayPhoto] {
        let response = try JSONDecoder().decode(PixabayWrapper.self, from: jsonData)
        return response.hits
    }
}


// MARK: - PixabayPhoto
struct PixabayPhoto: Codable {
    let webformatURL: String
    let largeImageURL: String
}
