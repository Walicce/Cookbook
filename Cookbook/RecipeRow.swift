//
//  RecipeRow.swift
//  Cookbook
//
//  Created by Nadya Simakovich on 15/06/2023.
//

import Foundation
import SwiftUI
import CoreData
import UIKit

struct RecipeRow: View {
       let recipe: Recipe
       
       var body: some View {
           HStack {
               recipe.image
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 50, height: 50)
               
               VStack(alignment: .leading) {
                   Text(recipe.name)
                       .font(.headline)
                   Text(recipe.category)
                       .font(.subheadline)
                       .foregroundColor(.gray)
               }
               
               Spacer()
           }
       }
   }
