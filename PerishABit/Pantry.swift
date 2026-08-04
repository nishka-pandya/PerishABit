//
//  Pantry.swift
//  PerisHabits
//
//  Created by Scholar on 6/24/26.
//

import SwiftUI
import SwiftData

struct Pantry: View {
    
    // @Query property wrapper reads data from model. It tells SwiftUI about any changes to the model so the view can update accordingly. Fetches FoodItemInfo instances stored in SwiftData
    
    @Query private var foods: [FoodItemInfo]
    
    // .modelContainer modifier inserts a modelContext into the SwiftUI environment, and the modeContext is accessible to all views under the container
    // Provides a connection between the view and the model container so that you can fetch, insert, and delete items in the container. Tracks all objects that have been created, modified, and deleted.
    @Environment(\.modelContext) private var context
    @State private var newFoodItem = ""
    @State private var newUseByDate = Date.now
    @State private var newQuantity: Int = 1
    @State private var newType = ""
    
    // To keep track of food item selected
    @State private var selectedFood: FoodItemInfo? // Optional type, it might hold an instance of FoodItemInfo or nothing
    
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
            
                // SwiftData provides each instance of a model type with its own identity separate from its data. It is no longer required to use the id since @Model provides an identifier
                
                // Loads rows of food items added by user
                List{
                    // foods is the
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
                        // Ability to select already existing food item
                        .onTapGesture {
                            selectedFood = food
                        }
                    }
                    .onDelete(perform: deleteItem) // Modifier to allow the user to swipe to delete an item in the list. Expects each row to have a unique identifier. Therefore use ForEach inside the list to tell SwiftUI to treat each row uniquely.
                    
                }
                .padding(.vertical, 60)
                .scrollContentBackground(.hidden)
                .shadow(radius:15)
                //.navigationTitle("Pantry")
                //.navigationBarTitleDisplayMode(.inline)
                .sheet(item: $selectedFood){ food in // Modal interface that animantes from the bottom of the screen, pushing the current view into the background
                    NavigationStack { // Navigation capabilities
                        EditFoodView(food: food)
                    }
                    
                }
                // Allows to place content over List without being covered 
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
                            
                            // Inserts new FoodItemInfo into the ModelContext
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
            
            // Deletes itemToDelete from ModelContext
            context.delete(itemToDelete)
        }
    }
}
                

    #Preview {
        Pantry()
            .modelContainer(for: FoodItemInfo.self, inMemory: true)
            // inMemory ensures that the interactive preview also uses SwiftData for data management
    }

