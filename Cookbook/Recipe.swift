//
//  Recipe.swift
//  Cookbook
//
//  Created by Nadya Simakovich on 15/06/2023.
//
import Foundation
import SwiftUI
import CoreData
import UIKit

struct Recipe: Identifiable {
      let id = UUID()
      let name: String
      let ingredients: String
      let instructions: String
      var image: Image
      let category: String
  }
