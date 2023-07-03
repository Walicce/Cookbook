//
//  UserRegistrationView.swift
//  Cookbook
//
//  Created by Nadya Simakovich on 15/06/2023.
//
import SwiftUI
import CoreData
import UIKit
import Foundation

struct UserRegistrationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var password: String = ""
    @State private var isRegistered: Bool = false
    @State private var isShowingLogin: Bool = false
    @State private var isButtonPressed: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isRegistered {
                    HomeView(firstName: firstName, lastName: lastName,password: password)
                } else {
                    Form {
                        Section(header: Text("Personal Information")) {
                            TextField("First Name", text: $firstName)
                                .foregroundColor(.primary)
                                .padding()
                                .background(Color.secondary.opacity(0.1))
                                .cornerRadius(8)
                            TextField("Last Name", text: $lastName)
                                .foregroundColor(.primary)
                                .padding()
                                .background(Color.secondary.opacity(0.1))
                                .cornerRadius(8)
                            SecureField("Password", text: $password)
                                .foregroundColor(.primary)
                                .padding()
                                .background(Color.secondary.opacity(0.1))
                                .cornerRadius(8)
                        }
                        
                        Section {
                            Button(action: registerUser) {
                                Text("Register")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(firstName.isEmpty || lastName.isEmpty || password.isEmpty ? Color.gray.opacity(0.5) : Color.blue)
                                    .cornerRadius(8)
                            }
                            .disabled(firstName.isEmpty || lastName.isEmpty || password.isEmpty)
                            
                            if isButtonPressed && userExists(withFirstName: firstName) {
                                Text("User with the same first name already exists")
                                    .foregroundColor(.red)
                                    .padding(.top)
                            }
                        }
                    }
                    .navigationBarTitle("Registration")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                isShowingLogin = true
                            }) {
                                Text("Login")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .sheet(isPresented: $isShowingLogin) {
                        LoginView(isShowingLogin: $isShowingLogin, isRegistered: $isRegistered, firstName: $firstName, lastName: $lastName, password: $password)
                    }
                    Button("Already registered? Login") {
                        isShowingLogin = true
                    }
                    .foregroundColor(.blue)
                    .font(.headline)
                }
            }
        }
    }
        
        func registerUser() {
            isButtonPressed = true
            
            guard !userExists(withFirstName: firstName) else {
                return // Display an error message or take appropriate action
            }
            
            let newUser = User(context: viewContext)
            newUser.firstName = firstName
            newUser.lastName = lastName
            newUser.password = password
            
            do {
                try viewContext.save()
                saveUserData()
                print("User registered")
                isRegistered = true
            } catch {
                print("Error saving user: \(error)")
            }
        }

    func saveUserData() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("user1.csv")
        print(fileURL);
        do {
            // Read existing data from the file, if any
            var existingData = try String(contentsOf: fileURL)

            // Append the new user's data to the existing data
            let newUserRow = "\(firstName),\(lastName),\(password)"
            existingData.append("\n\(newUserRow)")
            
            
            // Save the updated data back to the file
            try existingData.write(to: fileURL, atomically: true, encoding: .utf8)

            isRegistered = true
            print("User data saved successfully")
        } catch {
            print("Error saving user data: \(error)")
            isRegistered = false
        }

        print("File URL: \(fileURL)")
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func userExists(withFirstName firstName: String) -> Bool {
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "firstName == %@", firstName)
            fetchRequest.fetchLimit = 1
            
            do {
                let count = try viewContext.count(for: fetchRequest)
                return count > 0
            } catch {
                print("Error fetching user: \(error)")
                return false
            }
        }
}
