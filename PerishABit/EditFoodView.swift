//
//  EditFoodView.swift
//  PerisHabits
//
//  Created by Scholar on 7/10/26.
//

import SwiftUI

struct EditFoodView: View {
    var food: FoodItemInfo
    @State private var newFoodName: String
    @State private var newUseByDate: Date
    @State private var newType: String
    @State private var newQuantity: Int
    @Environment(\.dismiss) private var dismiss
    
    init(food: FoodItemInfo){
        self.food = food
        _newFoodName = State(initialValue: food.name)
        _newUseByDate = State(initialValue: food.useByDate)
        _newType = State(initialValue: food.type)
        _newQuantity = State(initialValue: food.quantity)
    }
    
    private var foodTypes: Dictionary = ["Leftovers": "Highest", "Dairy":"Medium-High", "Fresh Produce": "Medium", "Meats": "High", "Seafood": "High", "Condiments": "Lower", "Fruit": "Lower"]
    
    var body: some View {
        ZStack{
            Color.green.opacity(0.15)
                .ignoresSafeArea()
            VStack{
                Text("Edit Food")
                    .font(.title)
                    .fontDesign(.serif)
                    .fontWeight(.bold)
                    .foregroundStyle(.green)
                    .brightness(-0.4)
                    .padding()
                    . frame(minWidth:120, maxWidth:.infinity, alignment:.center)
                    .background(.green.opacity(0.45))
                Form {
                    TextField("Name", text: $newFoodName)
                        .fontDesign(.serif)
                    //TextField("Type", text: $newType)
                    Picker("Food Type", selection: $newType){
                        ForEach(foodTypes.keys.sorted(), id: \.self){ type in
                            Text("\(type)")
                                .fontDesign(.serif)
                            
                        }
                    }
                    .fontDesign(.serif)
                    DatePicker("Use By Date", selection: $newUseByDate, in: Date.distantPast...Date.distantFuture, displayedComponents: .date)
                        .fontDesign(.serif)
                    Picker("Quantity", selection: $newQuantity){
                        ForEach(1...100, id: \.self){ quant in
                            Text("\(quant)")
                        }
                    }
                    .fontDesign(.serif)
                    
                }
                .scrollContentBackground(.hidden)
                .shadow(radius:15)
            }
        }
        //.navigationTitle("Edit Food")
        //.navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .cancellationAction){
                Button("Cancel"){
                    dismiss()
            
                }
                .fontDesign(.serif)
            }
            ToolbarItem(placement: .confirmationAction){
                Button("Save"){
                    food.name = newFoodName
                    food.type = newType
                    food.useByDate = newUseByDate
                    food.quantity = newQuantity
                    dismiss()
                    
                }
                .fontDesign(.serif)
                
            }
        }
    }
}

#Preview {
    NavigationStack{
        EditFoodView(food: FoodItemInfo(name: "Test", useByDate: Date.now, quantity: 1, type: "Leftovers"))
    }
}
