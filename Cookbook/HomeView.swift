import Foundation
import SwiftUI
import CoreData
import UIKit


struct HomeView: View {
    let firstName: String
    let lastName: String
    let password: String
    @State private var isShowingAddRecipeView = false
    @State private var isShowingRecipes = false
    @State private var searchText = ""
    @State private var selectedCategoryIndex = 0
    @State private var selectedRecipe: Recipe? = nil
    @State private var isLoggedOut = false
    private func logout() {
        isLoggedOut = true
    }
    
    let categories = ["All", "Breakfast", "Lunch", "Dinner", "Dessert"]
    
    let allRecipes: [Recipe] = [
        Recipe(name: "Spaghetti Carbonara", ingredients: "Pasta, Eggs, Bacon, Parmesan Cheese", instructions: "1. Cook pasta\n2. Fry bacon\n3. Whisk eggs and cheese\n4. Mix all ingredients together", image: Image("spaghetti"), category: "Lunch"),
        Recipe(name: "Chicken Stir Fry", ingredients: "Chicken, Vegetables, Soy Sauce", instructions: "1. Cook chicken\n2. Stir-fry vegetables\n3. Add soy sauce\n4. Mix with chicken", image: Image("stirfry"), category: "Dinner"),
        Recipe(name: "Baked Salmon", ingredients: "Salmon fillet, Lemon, Olive oil, Salt, Pepper", instructions: "1. Preheat the oven\n2. Season salmon with salt and pepper\n3. Place lemon slices on top\n4. Drizzle with olive oil\n5. Bake until cooked through", image: Image("salmon"), category: "Dinner"),
        Recipe(name: "Caesar Salad", ingredients: "Romaine lettuce, Croutons, Parmesan cheese, Caesar dressing", instructions: "1. Wash and chop lettuce\n2. Add croutons and Parmesan cheese\n3. Toss with Caesar dressing", image: Image("caesarsalad"), category: "Lunch"),
        Recipe(name: "Chocolate Chip Cookies", ingredients: "Flour, Butter, Sugar, Chocolate chips, Vanilla extract", instructions: "1. Preheat the oven\n2. Cream butter and sugar\n3. Add flour, chocolate chips, and vanilla extract\n4. Bake until golden brown", image: Image("cookies"), category: "Dessert"),
        Recipe(name: "Grilled Chicken", ingredients: "Chicken breast, Olive oil, Salt, Pepper", instructions: "1. Preheat the grill\n2. Season chicken with salt and pepper\n3. Grill until cooked through", image: Image("grilledchicken"), category: "Dinner"),
        Recipe(name: "Caprese Salad", ingredients: "Tomatoes, Fresh mozzarella, Basil, Balsamic glaze", instructions: "1. Slice tomatoes and mozzarella\n2. Arrange on a plate with basil leaves\n3. Drizzle with balsamic glaze", image: Image("capresesalad"), category: "Lunch"),
        Recipe(name: "Apple Pie", ingredients: "Apples, Sugar, Cinnamon, Pie crust", instructions: "1. Preheat the oven\n2. Peel and slice apples\n3. Mix with sugar and cinnamon\n4. Place filling in pie crust\n5. Bake until crust is golden brown", image: Image("applepie"), category: "Dessert"),
        Recipe(name: "Omelette", ingredients: "Eggs, Milk, Cheese, Vegetables, Salt, Pepper", instructions: "1. Beat eggs and milk\n2. Heat a non-stick pan\n3. Pour in egg mixture\n4. Add cheese and vegetables\n5. Cook until set", image: Image("omelette"), category: "Breakfast"),
        Recipe(name: "Pasta Primavera", ingredients: "Pasta, Mixed vegetables, Olive oil, Garlic, Parmesan cheese", instructions: "1. Cook pasta\n2. Sauté garlic in olive oil\n3. Add vegetables and cook until tender\n4. Toss with cooked pasta and Parmesan cheese", image: Image("pastaprimavera"), category: "Dinner"),
        Recipe(name: "Greek Salad", ingredients: "Cucumber, Tomatoes, Red onion, Kalamata olives, Feta cheese, Olive oil, Lemon juice", instructions: "1. Chop cucumbers, tomatoes, and red onion\n2. Add olives and feta cheese\n3. Dress with olive oil and lemon juice", image: Image("greeksalad"), category: "Lunch"),
        Recipe(name: "Blueberry Pancakes", ingredients: "Flour, Milk, Blueberries, Eggs, Sugar, Baking powder", instructions: "1. Mix flour, milk, eggs, sugar, and baking powder\n2. Gently fold in blueberries\n3. Cook pancakes on a griddle\n4. Serve with maple syrup", image: Image("blueberrypancakes"), category: "Breakfast"),
        Recipe(name: "Beef Tacos", ingredients: "Ground beef, Taco shells, Lettuce, Tomato, Cheese, Sour cream", instructions: "1. Cook ground beef\n2. Warm taco shells\n3. Assemble tacos with beef, lettuce, tomato, cheese, and sour cream", image: Image("beeftacos"), category: "Dinner"),
        Recipe(name: "Fruit Salad", ingredients: "Assorted fruits (e.g., watermelon, berries, grapes, pineapple)", instructions: "1. Wash and chop fruits\n2. Combine in a bowl\n3. Chill before serving", image: Image("fruitsalad"), category: "Lunch"),
        Recipe(name: "Chocolate Brownies", ingredients: "Butter, Sugar, Eggs, Flour, Cocoa powder, Vanilla extract", instructions: "1. Preheat the oven\n2. Melt butter and mix with sugar\n3. Add eggs, flour, cocoa powder, and vanilla extract\n4. Bake until set", image: Image("brownies"), category: "Dessert"),
        Recipe(name: "Egg Fried Rice", ingredients: "Cooked rice, Eggs, Vegetables, Soy sauce", instructions: "1. Heat a pan\n2. Scramble eggs\n3. Add cooked rice and vegetables\n4. Stir in soy sauce", image: Image("friedrice"), category: "Dinner"),
        Recipe(name: "Chicken Caesar Wrap", ingredients: "Grilled chicken, Romaine lettuce, Caesar dressing, Tortilla", instructions: "1. Warm tortilla\n2. Spread Caesar dressing\n3. Layer with grilled chicken and lettuce\n4. Roll up tightly", image: Image("chickenwrap"), category: "Lunch"),
        Recipe(name: "Banana Bread", ingredients: "Ripe bananas, Flour, Sugar, Butter, Eggs, Baking soda", instructions: "1. Preheat the oven\n2. Mash bananas\n3. Mix with flour, sugar, butter, eggs, and baking soda\n4. Bake until golden brown", image: Image("bananabread"), category: "Dessert"),
        Recipe(name: "Vegetable Soup", ingredients: "Assorted vegetables, Vegetable broth, Herbs, Salt, Pepper", instructions: "1. Chop vegetables\n2. Simmer in vegetable broth with herbs, salt, and pepper\n3. Cook until vegetables are tender", image: Image("vegetablesoup"), category: "Lunch"),
        Recipe(name: "Pancakes", ingredients: "Flour, Milk, Eggs, Sugar, Baking powder", instructions: "1. Mix flour, milk, eggs, sugar, and baking powder\n2. Cook pancakes on a griddle\n3. Serve with your favorite toppings", image: Image("pancakes"), category: "Breakfast"),
        Recipe(name: "Hamburger", ingredients: "Ground beef, Buns, Lettuce, Tomato, Onion, Pickles, Condiments", instructions: "1. Shape ground beef into patties\n2. Grill or cook in a pan\n3. Assemble burger with buns, lettuce, tomato, onion, pickles, and condiments", image: Image("hamburger"), category: "Dinner"),
        Recipe(name: "Mango Salsa", ingredients: "Mango, Red onion, Jalapeno, Cilantro, Lime juice, Salt", instructions: "1. Dice mango, red onion, and jalapeno\n2. Chop cilantro\n3. Mix with lime juice and salt", image: Image("mangosalsa"), category: "Appetizer"),
        Recipe(name: "French Toast", ingredients: "Bread, Eggs, Milk, Cinnamon, Vanilla extract", instructions: "1. Beat eggs, milk, cinnamon, and vanilla extract\n2. Dip bread slices in the mixture\n3. Cook on a griddle until golden brown", image: Image("frenchtoast"), category: "Breakfast"),
        Recipe(name: "Shrimp Pasta", ingredients: "Shrimp, Pasta, Garlic, Olive oil, Lemon juice, Parsley", instructions: "1. Cook pasta\n2. Sauté garlic in olive oil\n3. Add shrimp and cook until pink\n4. Toss with cooked pasta, lemon juice, and parsley", image: Image("shrimppasta"), category: "Dinner"),
        Recipe(name: "Cobb Salad", ingredients: "Lettuce, Chicken breast, Bacon, Avocado, Tomatoes, Blue cheese, Hard-boiled eggs, Ranch dressing", instructions: "1. Chop lettuce\n2. Add cooked chicken, bacon, avocado, tomatoes, blue cheese, and hard-boiled eggs\n3. Drizzle with ranch dressing", image: Image("cobbsalad"), category: "Lunch"),
        Recipe(name: "Pumpkin Soup", ingredients: "Pumpkin, Onion, Garlic, Vegetable broth, Cream, Nutmeg", instructions: "1. Cook pumpkin, onion, and garlic\n2. Blend with vegetable broth and cream\n3. Season with nutmeg", image: Image("pumpkinsoup"), category: "Lunch"),
        Recipe(name: "Cheese Quesadilla", ingredients: "Tortilla, Cheese, Salsa, Sour cream", instructions: "1. Heat a pan\n2. Place tortilla on the pan\n3. Sprinkle cheese and add salsa\n4. Fold tortilla in half\n5. Cook until cheese melts\n6. Serve with sour cream", image: Image("quesadilla"), category: "Lunch")
    ]
    
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty && selectedCategoryIndex == 0 {
            return allRecipes
        } else if selectedCategoryIndex > 0 && selectedCategoryIndex < categories.count {
            let category = categories[selectedCategoryIndex]
            return allRecipes.filter { $0.category == category }
        } else {
            return allRecipes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    
    var body: some View {
        VStack {
            Text("Cookbook")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top)
            
            Text("Welcome, \(firstName) \(lastName)!")
                .font(.headline)
                .padding(.top)
            
            SearchBar(searchText: $searchText)
                .padding([.horizontal, .top])
                .frame(maxWidth: 400)
            
            Picker(selection: $selectedCategoryIndex, label: Text("Category")) {
                ForEach(0..<categories.count, id: \.self) { index in
                    Text(categories[index])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            
            List(filteredRecipes) { recipe in
                Button(action: {
                    selectedRecipe = recipe
                }) {
                    RecipeRow(recipe: recipe)
                }
            }
            
            Spacer()
            
            if isShowingRecipes {
                NavigationLink(destination: ContentView()) {
                    Text("See daily recipes")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom)
                .frame(maxWidth: .infinity)
            } else {
                Button(action: {
                    isShowingRecipes = true
                }) {
                    Text("See daily recipes")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom)
                .frame(maxWidth: .infinity)
            }
            
        }
        
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .sheet(item: $selectedRecipe) { recipe in
            RecipeDetailView(recipe: recipe)
        }
        .padding()
        .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
    }
    
}
