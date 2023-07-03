//
//  ContentView.swift
//  Cookbook
//
//  Created by Nadya Simakovich on 03/07/2023.
//

import Foundation
import SwiftUI
import UIKit

struct ContentView: View {
@State private var recipes: [Recipe] = [
Recipe(name: "Spaghetti Carbonara", ingredients: "Pasta, Eggs, Bacon, Parmesan Cheese", instructions: "1. Cook pasta\n2. Fry bacon\n3. Whisk eggs and cheese\n4. Mix all ingredients together", image: Image("spaghetti"), category: "Lunch"),
Recipe(name: "Chicken Stir Fry", ingredients: "Chicken, Vegetables, Soy Sauce", instructions: "1. Cook chicken\n2. Stir-fry vegetables\n3. Add soy sauce\n4. Mix with chicken", image: Image("stirfry"),category:  "Dinner")
]

@State private var isShowingAddRecipeView = false
@State private var currentIndex = 0

var body: some View {
NavigationView {
VStack {
   Spacer()
   
   RecipeCard(recipe: recipes[currentIndex])
       .gesture(
           DragGesture()
               .onEnded { value in
                   if value.translation.width < 0 {
                       // Swipe left
                       currentIndex = min(currentIndex + 1, recipes.count - 1)
                   } else if value.translation.width > 0 {
                       // Swipe right
                       currentIndex = max(currentIndex - 1, 0)
                   }
               }
       )
   
   Spacer()
   
   HStack {
       Button(action: {
           currentIndex = max(currentIndex - 1, 0)
       }) {
           Image(systemName: "chevron.left")
               .font(.title)
       }
       .padding(.leading)
       .disabled(currentIndex == 0)
       
       Spacer()
       
       Button(action: {
           currentIndex = min(currentIndex + 1, recipes.count - 1)
       }) {
           Image(systemName: "chevron.right")
               .font(.title)
       }
       .padding(.trailing)
       .disabled(currentIndex == recipes.count - 1)
   }
   .padding(.bottom)
}
.navigationBarTitle("Recipes")
.navigationBarItems(trailing: Button(action: {
   isShowingAddRecipeView = true
}) {
   Image(systemName: "plus")
})
.sheet(isPresented: $isShowingAddRecipeView) {
   AddRecipeView(isPresented: $isShowingAddRecipeView, onSave: { newRecipe in
       recipes.append(newRecipe)
   })
}
}
}
}
