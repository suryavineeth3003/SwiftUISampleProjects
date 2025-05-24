//
//  AddTransactionView.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 03/05/25.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AddTransactionViewModel
   
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter title", text: $viewModel.title)
                TextField("Enter Amount", text: $viewModel.amount)
                .keyboardType(.decimalPad)
                DatePicker("Select date", selection: $viewModel.date)
                Picker("Select Type", selection: $viewModel.type) {
                    ForEach(TransactionType.allCases, id: \.self) { transactionType in
                        Text(transactionType.displayString)
                    }
                }
            }.navigationTitle("Add transaction")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save") {
                            viewModel.addTransaction()
                            dismiss()
                        }
                    }
                }
        }
    }
}

#Preview {
    AddTransactionView(viewModel: AddTransactionViewModel(context: FinanceTrackerPersistenceManager().persistenceContainer.viewContext))
}
