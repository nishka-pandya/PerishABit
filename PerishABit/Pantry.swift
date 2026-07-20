//
//  Pantry.swift
//  PerisHabits
//
//  Created by Scholar on 6/24/26.
//

import SwiftUI
import SwiftData

struct Pantry: View {
    
    @Query private var foods: [FoodItemInfo]
    @Environment(\.modelContext) private var context
    @State private var newFoodItem = ""
    @State private var newUseByDate = Date.now
    @State private var newQuantity: Int = 1
    @State private var newType = ""
    @State private var selectedFood: FoodItemInfo?
    
    private var foodTypes: Dictionary = ["Leftovers": "Highest", "Dairy":"Medium-High", "Fresh Produce": "Medium", "Meats": "High", "Seafood": "High", "Condiments": "Lower", "Fruit": "Lower"]
    
    // Originally was going to create an algorithm to rank items in dashboard based on value assigned but decided it would be better to just let the user set a goal for when they want to use the food item by
    
    var body: some View {
        NavigationStack{
            ZStack(alignment:Alignment(horizontal: .center, vertical: .top)){
                Color.green.opacity(0.15)
                    .ignoresSafeArea()
                Text("Refrigerator")
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.serif)
                    .padding(5)
                    .frame(minWidth:120, maxWidth:.infinity, alignment:.center)
                    .foregroundStyle(.green)
                    .brightness(-0.4)
                    .background(.green.opacity(0.45))
            
                List{
                    ForEach(foods) { food in
                        HStack{
                            Text(food.name)
                                .font(.title3)
                                .fontDesign(.serif)
                            Spacer()
                            Text(food.useByDate, format:.dateTime.month(.wide).day().year())
                                .font(.title3)
                                .fontDesign(.serif)
                        }
                        
                        .onTapGesture {
                            selectedFood = food
                        }
                    }
                    .onDelete(perform: deleteItem)
                    
                }
                .padding(.vertical, 60)
                .scrollContentBackground(.hidden)
                .shadow(radius:15)
                //.navigationTitle("Pantry")
                //.navigationBarTitleDisplayMode(.inline)
                .sheet(item: $selectedFood){ food in
                    NavigationStack {
                        EditFoodView(food: food)
                    }
                    
                }
                .safeAreaInset(edge: .bottom){
                    VStack(alignment: .center, spacing: 20){
                        Text("New Item")
                            .font(.headline)
                            .fontDesign(.serif)
                            .foregroundStyle(.green)
                            .brightness(-0.4)
                            .fontWeight(.bold)
                        VStack{
                            TextField("Name", text: $newFoodItem)
                                .textFieldStyle(.roundedBorder)
                                .fontDesign(.serif)
                            //TextField("Type of Food", text: $newLocation)
                            //.textFieldStyle(.roundedBorder)
                            HStack{
                                Text("Food Type")
                                    .fontDesign(.serif)
                                    .foregroundStyle(.green)
                                    .brightness(-0.4)
                                    //.fontWeight(.bold)
                                Picker("Type of Food", selection: $newType){
                                    ForEach(foodTypes.keys.sorted(), id: \.self){ type in
                                        Text("\(type)")
                                        
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height: 100)
                                .fontDesign(.serif)
                            }
                            HStack{
                                Text("Use By Date")
                                    .fontDesign(.serif)
                                    .foregroundStyle(.green)
                                    .brightness(-0.4)
                                    //.fontWeight(.bold)
                                DatePicker(selection: $newUseByDate, in: Date.distantPast...Date.distantFuture, displayedComponents: .date){}
                                    .frame(maxWidth: .infinity, alignment:.center)
                                    .fontDesign(.serif)
                            }
                            HStack{
                                Text("Quantity")
                                    .fontDesign(.serif)
                                    .foregroundStyle(.green)
                                    .brightness(-0.4)
                                Picker("Quantity", selection: $newQuantity){
                                    ForEach(1...100, id: \.self){ quant in
                                        Text("\(quant)")
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height:100)
                            }
                        }
                        
                        
                        
                        Button("Save"){
                            let newFood = FoodItemInfo(name: newFoodItem, useByDate: newUseByDate, quantity: newQuantity, type: newType)
                            context.insert(newFood)
                            newFoodItem = ""
                            newUseByDate = .now
                            newQuantity = 1
                            newType = ""
                        }
                        .bold()
                        .fontDesign(.serif)
                        .padding()
                        .foregroundStyle(.green)
                        .brightness(-0.4)
                        .background(Color.green.opacity(0.45))
                        .cornerRadius(20)
                    }
                    .padding()
                    .background(.bar)
                }
            }
        }
        
    }
    
    func deleteItem(at offsets: IndexSet){
        for index in offsets {
            let itemToDelete = foods[index]
            context.delete(itemToDelete)
        }
    }
}
                

    #Preview {
        Pantry()
            .modelContainer(for: FoodItemInfo.self, inMemory: true)
    }

