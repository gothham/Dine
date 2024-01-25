//
//  UserManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

protocol UserManagabale {
    func addUser(_ account: Account)
    func removeUser(_ account: Account)
    func checkUserPresence(_ account: Account) -> Bool
    func checkUserPresence(_ username: String) -> Bool
    func searchUser(_ username: String) -> Account?
    func getNumberOfUsers() -> Int
}

class UserManager: UserManagabale {
    private var users: [Account] = [
        Account(id: "TechDev_123", password: "StrongP@ss123", accountStatus: .active, userRole: .manager)
    ]
    
    func addUser(_ account: Account) {
        users.append(account)
    }
    
    func removeUser(_ account: Account) {
        if let index = users.firstIndex(where: { $0 == account }) {
            users.remove(at: index)
        }
    }
    
    func checkUserPresence(_ account: Account) -> Bool {
        return users.contains(where: { $0 == account })
    }
    
    func checkUserPresence(_ username: String) -> Bool {
        return users.contains(where: { $0.getId() == username })
    }
    
    func searchUser(_ username: String) -> Account? {
        if let account = users.first(where: { $0.getId() == username }) {
            return account
        } else {
            return nil
        }
    }
    
    func isValidLogin(username: String, password: String) -> Bool {
        return users.contains(where: {$0.getId() == username && $0.getPassword() == password })
    }
    
    func getNumberOfUsers() -> Int {
        return users.count
    }
}