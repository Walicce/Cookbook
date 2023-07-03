//
//  SearchBar.swift
//  Cookbook
//
//  Created by Nadya Simakovich on 15/06/2023.
//

import Foundation
import SwiftUI
import CoreData
import UIKit

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 8)
            .opacity(searchText.isEmpty ? 0 : 1)
        }
    }
}
 
