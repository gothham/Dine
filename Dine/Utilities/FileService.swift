//
//  FileService.swift
//  Dine
//
//  Created by doss-zstch1212 on 19/01/24.
//

import Foundation

class FileService {
    func isFileAvailable(atPath path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    /// Checks if a file with the specified name exists in the document directory.
    /// - Parameter fileName: The name of the file to check for existence.
    /// - Returns: `true` if the file exists, `false` otherwise.
    func doesFileExistInDocumentDirectory(fileName: String) -> Bool {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return false
        }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: fileURL.path)
    }

}