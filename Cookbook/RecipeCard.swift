//
//  RecipeCard.swift
//  Cookbook
//
//  Created by Nadya Simakovich on 15/06/2023.
//
import Foundation
import SwiftUI
import CoreData
import UIKit

struct RecipeCard: View {
       let recipe: Recipe
       
       var body: some View {
           VStack(alignment: .leading) {
               VStack(alignment: .leading, spacing: 10) {
                   recipe.image
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(height: 150)
                   
                   Text(recipe.name)
                       .font(.headline)
                   
                   Text("Ingredients:")
                       .font(.headline)
                   
                   Text(recipe.ingredients)
                   
                   Text("Instructions:")
                       .font(.headline)
                   
                   Text(recipe.instructions)
               }
               .padding()
               .foregroundColor(.black)
               .background(
                   RoundedRectangle(cornerRadius: 10)
                       .fill(Color.white)
                       .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
               )
               .padding(10)
           }
       }
   }
