//
//  LocalFileManager.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 02/01/2023.
//

import SwiftUI


final class LocalFileManager {
    
    //MARK: - Instance
    static let instance = LocalFileManager()
    
    
    //MARK: - Init
    private init() { }
    
    
    //MARK: - Methods
    
    func saveImage(image: UIImage, folderName: String, imageName: String) {
        
        createFolderIfNeeded(with: folderName)
        
        guard
            let data = image.pngData(),
            let url = getImageURLPath(folderName: folderName, imageName: imageName) else { return }
        
        do {
            try data.write(to: url)
            
        } catch let error {
            print("Error saving image. ", error)
        }
    }
    
    func getImage(folderName: String, ImageName: String) -> UIImage? {
        
        guard let url = getImageURLPath(folderName: folderName, imageName: ImageName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    
    
    //MARK: - Helper Methods
    
    private func createFolderIfNeeded(with folderName: String) {
        guard let url = getFolderURLPath(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                
            } catch let error {
                print("Error creating directory. ", error)
            }
        }
    }
    
    private func getFolderURLPath(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory,
                                                 in: .userDomainMask).first else {
            return nil
        }
        
        return url.appendingPathComponent(folderName)
    }
    
    private func getImageURLPath(folderName: String, imageName: String) -> URL? {
        guard let url = getFolderURLPath(folderName: folderName) else {
            return nil
        }
        
        return url.appendingPathComponent(imageName + ".png")
    }
}
