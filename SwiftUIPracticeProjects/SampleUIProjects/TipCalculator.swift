//
//  TipCalculator.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 17/04/25.
//

import SwiftUI
/*
-----------------------------------
| 💰 Bill Amount: [TextField]     |
| % Tip:        [Picker]          |
| 👥 People:     [Stepper/Picker] |
-----------------------------------
| 💸 Tip Amount: ₹12.50           |
| 🧾 Total:      ₹112.50          |
| 👤 Per Person: ₹28.13           |
-----------------------------------
 
 */

struct TipCalculator: View {
    @State private var amount: String = ""
    @State private var selectedTip: Int = 0
    @State private var numberOfPeople: Int = 1
    var body: some View {
        List {
            Section {
                HStack(){
                    Text("Bill Amount:")
                    Spacer()
                    TextField("Enter Amount", text: $amount)
                }
                
                Picker("% Tip:", selection: $selectedTip) {
                    ForEach([0,10,20,30,40], id: \.self) { value in
                        Text("\(value)")
                    }
                }.pickerStyle(.menu)
                
                Stepper(value: $numberOfPeople, in: 1...20) {
                    Text("\(numberOfPeople) people")
                }
            }
            
            Section {
                HStack {
                    Text("Tip Amount:")
                    Spacer()
                    Text("\((Float(amount) ?? 0.0) * Float(selectedTip)/100)")
                }
                HStack {
                    Text("Total:")
                    Spacer()
                    Text("\(self.getToTalAmount())")
                }
                HStack {
                    Text("Per Person:")
                    Spacer()
                    Text("\(self.getToTalAmount()/Float(numberOfPeople))")
                }
            }
        }
    }
    
    func getToTalAmount() -> Float {
        let amount: Float = Float(amount) ?? 0.0
        let total = amount + (amount * Float(selectedTip))/100
        return total
    }
}

#Preview {
    TipCalculator()
}
