//
//  AddTransactionViewModel.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 03/05/25.
//

import Foundation
import CoreData

class AddTransactionViewModel: ObservableObject {
    @Published  var title: String = ""
    @Published  var type: TransactionType = .income
    @Published  var amount: String = "0.0"
    @Published  var date: Date = Date()
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addTransaction() {
        let transaction = TransactionEntity(context: self.context)
        transaction.id = UUID().uuidString
        transaction.title = self.title
        transaction.amount = Double(self.amount) ?? 0.0
        transaction.date = self.date
        transaction.type = Int64(self.type.rawValue)
        self.saveTransaction()
    }
    
    func saveTransaction() {
        do {
            try context.save()
        } catch {
            
        }
    }
}
