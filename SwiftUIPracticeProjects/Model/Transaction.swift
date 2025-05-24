//
//  Transaction.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 03/05/25.
//

import Foundation
import CoreData

enum TransactionType: Int, CaseIterable {
    case income
    case expense
    
    var displayString: String {
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}

struct Transaction: Identifiable {
    var id: UUID = UUID()
    var title: String
    var amount: Double
    let date: Date
    let type: TransactionType
}

extension Transaction {
    func toTransactionEntity(in context: NSManagedObjectContext) -> TransactionEntity {
        let entity = TransactionEntity(context: context)
        entity.id = id.uuidString
        entity.title = title
        entity.amount = amount
        entity.date = date
        entity.type = Int64(type.rawValue)
        return entity
    }
    
}
