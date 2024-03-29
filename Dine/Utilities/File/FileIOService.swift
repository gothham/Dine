//
//  FileIOController.swift
//  Dine
//
//  Created by doss-zstch1212 on 12/01/24.
//

import Foundation

@frozen enum CustomDirectories: String {
    case folderPath = "orders"
}

class FileIOService {
    /// Saves Codable data to a file in the document directory.
    /// - Parameters:
    ///   - data: The Codable data to be saved.
    ///   - fileName: The name of the file to which the data will be saved.
    /// - Returns: `true` if the data is successfully saved, `false` otherwise.
    /// - Throws: An error if there's an issue encoding or writing the data to the file.
    static func saveDataToFile<T: Codable>(data: T, fileName: String) -> Bool {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(data)
            if let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: fileName) {
                try encodedData.write(to: filePath)
                return true
            }
        } catch {
            print("Error saving data to file: \(error)")
        }
        
        return false
    }
    
    /**
     Reads Codable data from a JSON file in the app's document directory.

     - Parameters:
        - dataType: The type of the Codable data to be retrieved.
        - fileName: The name of the file (including extension) from which to read the data.

     - Returns:
        The decoded data of type `dataType`, or `nil` if there was an issue reading or decoding the data.

     - Throws:
        An error of type `Error` if there is an issue reading or decoding the data.

     - Important:
        This function assumes that the data type `T` conforms to the `Codable` protocol.

     - Note:
        The file should be located in the app's document directory.
        Example usage:
        ```
        if let user: User = try? readDataFromFile(fileName: "userData.json") {
            print("User data retrieved: \(user)")
        }
        ```

     - SeeAlso:
        `Codable` protocol for data encoding and decoding.
        `FileManager` for accessing file system locations.
     */
    static func readDataFromFile<T: Codable>(fileName: String) throws -> T? {
        do {
            if let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: fileName) {
                let fileData = try Data(contentsOf: filePath)
                
                // Decode
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: fileData)
                
                return decodedData
            }
        } catch {
            throw error
        }
        
        return nil
    }
    
    
    /// Check if a file with a given name exists in the app's Document directory.
    /// - Parameter fileName: The name of the file (including extension) to check.
    /// - Returns: `true` if the file exists, `false` otherwise.
    static func fileExists(withName fileName: String) -> Bool {
        let fileManager = FileManager.default
        guard let filePath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: fileName).absoluteString else { return false }
        
        return fileManager.fileExists(atPath: filePath)
    }
    
    /// Function to get the document directory path
    func getDocumentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    func writeOrderToFile(order: Order) {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let ordersDirectory = documentDirectory.appendingPathComponent("Orders")

        if !FileManager.default.fileExists(atPath: ordersDirectory.path) {
            do {
                try FileManager.default.createDirectory(at: ordersDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating Orders directory: \(error.localizedDescription)")
                return
            }
        }

        let orderURL = ordersDirectory.appendingPathComponent("myOrder.json")

        do {
            let data = try JSONEncoder().encode(order)
            try data.write(to: orderURL)
            print("Order successfully written to file.")
        } catch {
            print("Error saving Order: \(error.localizedDescription)")
        }
    }
    
    func readAllOrdersFromDirectory() -> [Order] {
        var orders: [Order] = []

        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let ordersDirectory = documentDirectory.appendingPathComponent("Orders")

        guard let directoryContents = try? FileManager.default.contentsOfDirectory(at: ordersDirectory, includingPropertiesForKeys: nil, options: []) else {
            print("Error reading Orders directory.")
            return orders
        }

        for orderURL in directoryContents {
            do {
                let data = try Data(contentsOf: orderURL)
                let order = try JSONDecoder().decode(Order.self, from: data)
                orders.append(order)
            } catch {
                print("Error reading Order from file: \(error.localizedDescription)")
            }
        }

        return orders
    }
}
