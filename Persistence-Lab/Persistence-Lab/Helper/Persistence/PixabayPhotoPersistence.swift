//
//  PixabayPhotoPersistence.swift
//  Persistence-Lab
//
//  Created by Anthony Gonzalez on 9/30/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation


struct PixabayPhotoPersistenceHelper {
    static let manager = PixabayPhotoPersistenceHelper()
    
    func save(newPhoto: PixabayPhoto) throws {
        try persistenceHelper.save(newElement: newPhoto)
    }
    
    func getPhoto() throws -> [PixabayPhoto] {
        return try persistenceHelper.getObjects()
    }
    
    private let persistenceHelper = PersistenceHelper<PixabayPhoto>(fileName: "photo.plist")
    
    private init() {}
}
