//
//  TransactionListViewModel.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 03/05/25.
//

import Foundation
import CoreData

class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction]  = []
    @Published var selectedTransactionType: TransactionType = .income
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    var totalExpenses: Double {
        return transactions.filter{$0.type == .expense}.reduce(0) { $0 + $1.amount }
    }
    
    var totalIncome: Double {
        return transactions.filter{$0.type == .income}.reduce(0) { $0 + $1.amount }
    }
    
    var totalBalance: Double {
        return totalIncome - totalExpenses
    }
    
    func addTransaction(transaction: Transaction) {
        transactions.append(transaction)
        let _ = transaction.toTransactionEntity(in: context)
        self.saveTransaction()
    }
    
    func deleteTransaction(indexSet: IndexSet) {
        let transaction = self.transactions.filter({$0.type == selectedTransactionType})[indexSet.first!]
        transactions.remove(at: transactions.firstIndex(where: {$0.id == transaction.id && $0.type == transaction.type})!)
        let fetchRequest = TransactionEntity.fetchRequest() as NSFetchRequest<TransactionEntity>
        fetchRequest.predicate = NSPredicate(format: "id == %@", transaction.id.uuidString as CVarArg)
        do {
            if let transactionEntiryToDelete = try context.fetch(fetchRequest).first {
                self.context.delete(transactionEntiryToDelete)
                self.saveTransaction()
            }
        } catch {
            
        }
    }
    
    func saveTransaction() {
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func fetchTransactions() {
        let fetchRequest = TransactionEntity.fetchRequest() as NSFetchRequest<TransactionEntity>
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TransactionEntity.date, ascending: false)]
        if self.selectedTransactionType != nil {
            fetchRequest.predicate = NSPredicate(format: "type == %d", self.selectedTransactionType.rawValue)
        }
        do {
            let transactionsFromDB = try context.fetch(fetchRequest)
            self.transactions = transactionsFromDB.map({Transaction(title: $0.title ?? "", amount: $0.amount, date: $0.date ?? Date(), type: TransactionType(rawValue: Int($0.type)) ?? .income)})
        } catch {
            
        }
    }
}
