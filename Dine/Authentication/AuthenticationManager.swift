//
//  AuthenticationManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 09/02/24.
//

import Foundation

class AuthenticationManager {
    private let userRespository: UserRepository
    
    init(userRespository: UserRepository) {
        self.userRespository = userRespository
    }
    
    func isLoginValid(username: String, password: String) throws -> Bool {
        guard let user = userRespository.searchUser(username: username) else {
            throw AuthenticationError.noUserFound
        }
        
        guard user.accountStatus == .active else {
            throw AuthenticationError.inactiveAccount
        }
        
        return user.password == password
    }
}
