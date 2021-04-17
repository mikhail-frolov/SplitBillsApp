//
//  ContentView.swift
//  SplitBillsApp
//
//  Created by Mikhail Frolov on 2021-04-17.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount : String = ""
    @State private var numberOfPeople : String = ""
    @State private var tipSelection = 1
    
    //stored property
    let tipPercentageList = [0, 5, 10, 15, 20]
    
    //computed Property
    var tipAmount : Double {
        let tipValue = (Double(self.checkAmount) ?? 0) / 100 * Double(self.tipPercentageList[self.tipSelection])
        
        return tipValue
    }
    
    var billAmount : Double{
        return ((Double(self.checkAmount) ?? 0) + self.tipAmount)
    }
    
    var amountPerPerson : Double{
        return (self.billAmount / (Double(self.numberOfPeople) ?? 2))
    }
    
    var body: some View {
       
        NavigationView{
         // VStack{
//        Text("Hello, Misha!")
//            .padding()
//            .foregroundColor(.red)
//            .background(Color.black)
//
//        Text("Split Bills")
    //
            Form{
                Section{
                TextField("Check Amount", text: self.$checkAmount)
                    .keyboardType(.decimalPad)
                
                TextField("Number of people", text: self.$numberOfPeople)
                    .keyboardType(.numberPad)
                } // Section
                
                Section(header: Text("How much tip do you want to leave?")){
                    
                    Picker("Tip Percentage",
                           selection: self.$tipSelection){
                        ForEach(0 ..< self.tipPercentageList.count){
                            Text("\(self.tipPercentageList[$0]) %")
                                .foregroundColor(.blue)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                }
                
                Section(header: Text("Bill Details")){
                    Text("Check Amount : $ \(self.checkAmount)")
                    Text("Number of people : \(self.numberOfPeople)")
                    Text("Tip Amount : $ \(self.tipAmount, specifier: "%.2f")")
                    Text("Bill Amount : $ \(self.billAmount, specifier: "%.2f")")
                }
                
                Section(header: Text("Final Split")){
                    Text("Amount Per Person : $ \(self.amountPerPerson, specifier: "%.2f")")
                        .foregroundColor(.green)
                        .bold()
                }
                
            }//Form
            
            .navigationBarTitle(Text("Split Bills"), displayMode: .automatic)
            
            }// NsvidationView
    }//Body
}//ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
