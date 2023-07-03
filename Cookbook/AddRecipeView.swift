import SwiftUI
import UIKit

struct AddRecipeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var recipeName: String = ""
    @State private var ingredients: String = ""
    @State private var instructions: String = ""
    @State private var category: String = ""
    @State private var image: UIImage? = nil
    @State private var isImagePickerPresented = false
    @Binding var isPresented: Bool
    var onSave: (Recipe) -> Void

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Recipe Details")) {
                    TextField("Recipe Name", text: $recipeName)
                    TextField("Ingredients", text: $ingredients)
                    TextField("Instructions", text: $instructions)
                    Picker("Category", selection: $category) {
                        Text("Breakfast").tag("Breakfast")
                        Text("Lunch").tag("Lunch")
                        Text("Dinner").tag("Dinner")
                        Text("Dessert").tag("Dessert")
                    }
                }

                Section {
                    Button(action: {
                        isImagePickerPresented = true
                    }) {
                        Text("Add Image")
                    }
                }

                Section {
                    Button("Save Recipe") {
                        saveRecipe()
                    }
                    .disabled(recipeName.isEmpty || ingredients.isEmpty || instructions.isEmpty || category.isEmpty || image == nil)
                }
            }
        }
        .navigationBarTitle("Add Recipe")
        .sheet(isPresented: $isImagePickerPresented, onDismiss: loadImage) {
            ImagePicker(image: $image)
        }
    }

    func saveRecipe() {
        guard let recipeImage = image else {
            return
        }

        guard recipeImage.jpegData(compressionQuality: 1.0) != nil else {
            return
        }

        let newRecipe = Recipe(name: recipeName, ingredients: ingredients, instructions: instructions, image: Image(uiImage: recipeImage), category: category)
        onSave(newRecipe)
        do {
            try viewContext.save()
            print("Recipe saved")
        } catch {
            print("Error saving recipe: \(error)")
        }
        isPresented = false
    }



    func loadImage() {
        guard let selectedImage = image else {
            return
        }

        let scaledImage = selectedImage
        image = scaledImage
    }
}
