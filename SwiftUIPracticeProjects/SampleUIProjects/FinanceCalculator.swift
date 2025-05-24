//
//  FinanceCalculator.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 03/05/25.
//

import SwiftUI

struct FinanceCalculator: View {
    @ObservedObject var viewModel: TransactionListViewModel
    @State private var showAddTransactionView = false
    var body: some View {
        NavigationStack {
            List {
                Section ("Balance") {
                    VStack {
                        LabeledContent("Total Income:", value: viewModel.totalIncome.formatted(.currency(code: "INR")))
                        LabeledContent("Total Expense:", value: viewModel.totalExpenses.formatted(.currency(code: "INR")))
                        LabeledContent("Total Balance:", value: viewModel.totalBalance.formatted(.currency(code: "INR")))
                    }
                }
                Section ("Transactions") {
                    TransactionFilterView(viewModel: viewModel)
                    ForEach(viewModel.transactions, id: \.id) { transaction in
                        VStack(alignment: .leading){
                            Text(transaction.title)
                                .font(.title)
                            Text(transaction.amount.formatted(.currency(code: "INR")))
                                .font(.headline)
                            Text(transaction.type.displayString)
                                .font(.subheadline)
                            Text(transaction.date.formatted(date: .abbreviated, time: .omitted))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }.onDelete { indexSet in
                        viewModel.deleteTransaction(indexSet: indexSet)
                    }
                }
            }.navigationTitle("Transactions")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            self.showAddTransactionView.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        
                    }
                }
                .sheet(isPresented: $showAddTransactionView) {
                    viewModel.fetchTransactions()
                } content: {
                    AddTransactionView(viewModel: AddTransactionViewModel(context: self.viewModel.context))
                }
                .onAppear {
                    viewModel.fetchTransactions()
                }
        }

    }
}

struct TransactionFilterView: View {
    @ObservedObject var viewModel: TransactionListViewModel
    var body: some View {
        Picker("Select Type", selection: Binding(get: {
            viewModel.selectedTransactionType
        }, set: { newValue in
            viewModel.selectedTransactionType = newValue
        })) {
            ForEach(TransactionType.allCases, id: \.self) { transactionType in
                Text(transactionType.displayString)
                    .tag(transactionType)
            }
        }.onChange(of: viewModel.selectedTransactionType) { oldValue, newValue in
            viewModel.fetchTransactions()
        }
    }
}

#Preview {
    FinanceCalculator(viewModel: TransactionListViewModel(context: FinanceTrackerPersistenceManager().persistenceContainer.viewContext))
}
