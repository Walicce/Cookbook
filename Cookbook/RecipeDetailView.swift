//
//  RecipeDetailView.swift
//  Cookbook
//
//  Created by Nadya Simakovich on 15/06/2023.
//

import Foundation
import SwiftUI
import CoreData
import UIKit

struct RecipeDetailView: View {
      let recipe: Recipe
      
      var body: some View {
          VStack {
              recipe.image
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .padding()
              
              Text(recipe.name)
                  .font(.title)
              
              Text("Ingredients:")
                  .font(.headline)
                  .padding(.top)
              
              Text(recipe.ingredients)
              
              Text("Instructions:")
                  .font(.headline)
                  .padding(.top)
              
              Text(recipe.instructions)
              
              Spacer()
          }
          .padding()
      }
  }
