//
//  ContentView.swift
//  CoreDataBootcamp
//
//  Created by Akhmed on 27.03.24.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)],
        animation: .default)
    private var fruits: FetchedResults<FruitEntity>
    
    @State private var newFruitName = ""
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    @State private var showingEditFruitAlert = false
    @State private var editFruitName = ""
    @State private var fruitToEdit: FruitEntity?
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Fruit Name", text: $newFruitName)
                    Button(action: {
                        addItem()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                .padding()
                
                List {
                    ForEach(fruits, id: \.self) { fruit in
                        HStack {
                            Text(fruit.name ?? "Unknown")
                                .foregroundStyle(fruit.isChecked ? Color.secondary : Color.black)
                                .onLongPressGesture {
                                    fruitToEdit = fruit
                                    editFruitName = fruit.name ?? ""
                                    showingEditFruitAlert = true
                                }
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    fruit.isChecked.toggle()
                                    do {
                                        try viewContext.save()
                                    } catch {
                                        showErrorAlert = true
                                        errorMessage = "Failed to update the fruit status."
                                        print(error.localizedDescription)
                                    }
                                }
                            }) {
                                Image(systemName: fruit.isChecked ? "checkmark.square" : "square")
                                    .foregroundStyle(fruit.isChecked ? .green : .gray)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Core Data with Fruits")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                .sheet(isPresented: $showingEditFruitAlert) {
                    EditFruitView(fruitName: $editFruitName, onSave: {
                        editItem()
                        showingEditFruitAlert = false
                    })
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            guard isNameValid(newFruitName) else {
                showErrorAlert = true
                errorMessage = "Name must be unique and contain only letters."
                return
            }
            
            let newFruit = FruitEntity(context: viewContext)
            newFruit.name = newFruitName
            do {
                try viewContext.save()
                newFruitName = "" // Сбросить имя после добавления
            } catch {
                showErrorAlert = true
                errorMessage = "Failed to save the fruit."
                print(error.localizedDescription)
            }
        }
    }
    
    private func editItem() {
        withAnimation {
            guard let fruitToEdit = fruitToEdit, !editFruitName.isEmpty, editFruitName.count >= 2 else {
                showErrorAlert = true
                errorMessage = "Name must be unique, contain only letters and be at least 2 characters long."
                return
            }
            
            fruitToEdit.name = editFruitName
            do {
                try viewContext.save()
                self.fruitToEdit = nil // Сбрасываем выбранный для редактирования фрукт
            } catch {
                showErrorAlert = true
                errorMessage = "Failed to edit the fruit."
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { fruits[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                showErrorAlert = true
                errorMessage = "Failed to delete the fruit."
                print(error.localizedDescription)
            }
        }
    }
    
    // Функция для проверки валидности имени фрукта
    private func isNameValid(_ name: String) -> Bool {
        let hasNonAlphabeticCharacters = name.rangeOfCharacter(from: CharacterSet.letters.inverted) != nil
        let isUnique = !fruits.contains(where: { $0.name == name })
        
        return !hasNonAlphabeticCharacters && isUnique && !name.isEmpty && name.count >= 2
    }
}


struct EditFruitView: View {
    @Binding var fruitName: String
    let onSave: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Fruit Name", text: $fruitName)
            }
            .navigationBarTitle("Edit Fruit", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                onSave()
            })
        }
    }
}



#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
