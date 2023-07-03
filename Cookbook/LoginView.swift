//
//  LoginView.swift
//  Cookbook
//
//  Created by Nadya Simakovich on 15/06/2023.
//

import SwiftUI
import CoreData
import UIKit
import Foundation

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContex
    @Binding var isShowingLogin: Bool
    @Binding var isRegistered: Bool
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var password: String
    
    @State private var showInvalidCredentialsMessage = false
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            TextField("First Name", text: $firstName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            Button(action: login) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.top)
            }
            .disabled(firstName.isEmpty || password.isEmpty)
            
            if showInvalidCredentialsMessage {
                Text("Invalid login credentials")
                    .foregroundColor(.red)
                    .padding(.top)
            }
            
            Button(action: {
                isShowingLogin = false
            }) {
                Text("Back")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.top)
            }
        }
        .padding()

    }
    
    func login() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("user1.csv")
        
        do {
            let existingData = try String(contentsOf: fileURL)
            let userDataRows = existingData.components(separatedBy: "\n")
            
            for row in userDataRows {
                let userData = row.components(separatedBy: ",")
                if userData.count == 3 {
                    let storedFirstName = userData[0]
                    let storedPassword = userData[2]
                    
                    if firstName == storedFirstName && password == storedPassword {
                        isRegistered = true
                        isShowingLogin = false
                        return
                    }
                }
            }
            
            // If the loop completes without finding a match
            showInvalidCredentialsMessage = true
        } catch {
            print("Error reading user data: \(error)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
