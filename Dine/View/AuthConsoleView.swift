//
//  AuthConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/01/24.
//

import Foundation

class AuthConsoleView {
    let userManager: UserManagabale
    
    init(userManager: UserManagabale) {
        self.userManager = userManager
    }
    
    func displayLoginPrompt() {
        print("Enter you username: ", terminator: "")
        guard let username = readLine() else {
            print("Enter a valid username!")
            displayLoginPrompt()
            return
        }
        
        print("Enter you password: ", terminator: "")
        guard let password = readLine() else {
            print("Enter a valid password!")
            displayLoginPrompt()
            return
        }
        
        
        // TODO: Call the login controller class
        let loginController = LoginController(userManager: userManager)
        if loginController.authenticateUserCredentials(username: username, password: password) {
            print("User successfully logged in!")
        } else {
            print("User not available!")
        }
    }
    
    func displaySignUpPrompt() {
        print("Enter a new username: ", terminator: "")
        guard let username = readLine() else {
            print("Enter a valid username!")
            displaySignUpPrompt()
            return
        }
        
        print("Enter a new password: ", terminator: "")
        guard let password = readLine() else {
            print("Enter a valid password!")
            displaySignUpPrompt()
            return
        }
        
        // TODO: Call the sign up controller class
        let signUpController = SignUpController(userManager: userManager)
        if signUpController.createAccount(username: username, password: password, role: .manager) {
            displayLoginPrompt()
        } else {
            displaySignUpPrompt()
        }
    }
}
