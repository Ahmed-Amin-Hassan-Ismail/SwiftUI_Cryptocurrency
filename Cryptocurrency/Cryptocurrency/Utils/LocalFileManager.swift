//
//  LocalFileManager.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 08/06/2023.
//

import Foundation


//MARK: - Singleton

final class LocalFileManager {
    
    //MARK: - Instance
    
    static let instance: LocalFileManager = {
        
        return LocalFileManager()
    }()
    
    
    //MARK: - Init
    
    private init() { }
    
    
    //MARK: - Methods
    
    func saveImage(imageData: Data, imageName: String, fileName: String) {
        
        createFolderIfNeeded(fileName: fileName)
        
        guard let url = imageURLPath(fileName: fileName, imageName: imageName) else { return }
        
        do {
            
            try imageData.write(to: url)
            
        } catch {
            
            print("Saving Error \(error)")
        }
        
    }
    
    func getImageDataFromLocal(imageName: String, fileName: String) -> Data? {
        
        guard let url = imageURLPath(fileName: fileName, imageName: imageName),
        FileManager.default.fileExists(atPath: url.path) else {
            
            return nil
        }
        
        var data: Data?
        
        do {
            
             data = try Data(contentsOf: url)
            
        } catch {
            
            print("Fetching Error \(error)")
        }
     
        return data
    }
    
    
    
    //MARK: - Private Helper Methods
    
    private func createFolderIfNeeded(fileName: String) {
         
        guard let url = folderURLPath(fileName: fileName) else { return }
        
        guard !FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            
        } catch {
            
            print("Creating file Error with file name. \(fileName)")
        }
    }
    
    private func folderURLPath(fileName: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            
            return nil
        }
        
        return url.appendingPathComponent(fileName + ".png")
    }
    
    private func imageURLPath(fileName: String, imageName: String) -> URL? {
        
        let folderURL = folderURLPath(fileName: fileName)
        
        return folderURL?.appendingPathComponent(imageName)
    }
}
