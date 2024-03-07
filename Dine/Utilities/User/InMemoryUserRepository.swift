//
//  InMemoryUserRepository.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/02/24.
//

import Foundation

enum UserRepositoryError: Error {
    case userNotFound
}

class InMemoryUserRepository: UserRepository {
    static let shared = InMemoryUserRepository()
    
    private init() {
        loadAccounts()
    }
    
    private var accounts: [Account] = []
    
    func addUser(_ user: Account) {
        accounts.append(user)
        saveAccounts()
    }
    
    func removeUser(_ user: Account) throws {
        if let index = accounts.firstIndex(where: { $0 == user }) {
            accounts.remove(at: index)
            saveAccounts()
        } else {
            throw UserRepositoryError.userNotFound
        }
    }
    
    func checkUserPresence(username: String) -> Bool {
        return accounts.contains(where: { $0.username == username })
    }
    
    func searchUser(username: String) -> Account? {
        return accounts.first(where: { $0.username == username })
    }
    
    func isUserActive(username: String) -> Bool {
        guard let user = searchUser(username: username) else { return false }
        return user.accountStatus == .active
    }
    
    func isManager(username: String) -> Bool {
        guard let user = searchUser(username: username) else { return false }
        return user.userRole == .manager
    }
    
    func getAccounts() -> [Account] {
        return accounts
    }
    
    private func saveAccounts() {
        Task {
            let csvDAO = CSVDataAccessObject()
            await csvDAO.save(to: .accountFile, entity: self)
        }
    }
    
    private func loadAccounts() {
        Task {
            let csvDAO = CSVDataAccessObject()
            if let accounts = await csvDAO.load(from: .billFile, parser: AccountParser()) as? [Account] {
                self.accounts = accounts
            }
        }
    }
}

extension InMemoryUserRepository: CSVWritable {
    func toCSVString() -> String {
        var csvString = "userId,username,password,accountStatus,userRole"
        for (index, account) in self.accounts.enumerated() {
            let row = account.toCSVString()
            
            // Append a new line if it's not the last account
            if index != self.accounts.count {
                csvString.append("\n")
            }
            
            csvString.append(row)
        }
        
        return csvString
    }
}
