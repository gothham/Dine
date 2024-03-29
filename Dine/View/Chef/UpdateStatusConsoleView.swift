//
//  ChefConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 30/01/24.
//

import Foundation

class UpdateStatusConsoleView {
    private let updateStatusService: UpdateStatusService = UpdateStatusController()
    
    func manageReceivedOrders() {
        guard let receivedOrders = updateStatusService.fetchReceivedOrders() else {
            print("No recieved orders found!")
            return
        }
        
        guard let order = promptForOrderSelection(from: receivedOrders) else {
            print("Invalid selection!")
            return
        }
        
        guard let status = promptForOrderStatusSelection() else { 
            print("Invalid selection")
            return
        }
        
        updateStatusService.changeStatus(for: order, to: status)
        
    }
    
    private func promptForOrderSelection(from orders: [Order]) -> Order? {
        while true {
            print("Received Orders:")
            for (index, order) in orders.enumerated() {
                let formattedOrder = String.formatOrderDetails(order)
                print("\(index + 1). \(formattedOrder)")
            }

            print("\nEnter the number of the order you want to choose (or 0 to cancel):")
            if let choiceString = readLine(), let orderNumber = Int(choiceString) {
                if orderNumber >= 1 && orderNumber <= orders.count {
                    let chosenOrder = orders[orderNumber - 1]
                    print("You have chosen order: \(chosenOrder.orderId)")
                    return chosenOrder
                } else {
                    print("Invalid choice. Please enter a number between 1 and \(orders.count) or 0 to cancel.")
                }
            } else {
                print("Invalid input. Please enter a number.")
            }
        }
    }

    
    private func promptForOrderStatusSelection() -> OrderStatus? {
        let allTableStatusCases = OrderStatus.allCases

        while true {
            print("Enter the number of the status you want to set (or 0 to cancel):")
            for (index, orderStatus) in allTableStatusCases.enumerated() {
                print("\(index + 1). \(orderStatus)")  // Start numbering from 1
            }

            if let choiceString = readLine(), let statusNumber = Int(choiceString) {
                if statusNumber >= 1 && statusNumber <= allTableStatusCases.count {
                    let chosenStatus = allTableStatusCases[statusNumber - 1]
                    print("Status changed: \(chosenStatus)")
                    return chosenStatus
                } else {
                    print("Invalid choice. Please enter a number between 1 and \(allTableStatusCases.count) or 0 to cancel.")
                }
            } else {
                print("Invalid input. Please enter a number.")
            }
        }
    }
}

