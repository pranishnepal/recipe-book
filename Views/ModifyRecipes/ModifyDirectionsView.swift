//
//  ModifyDirectionsView.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-29.
//

import SwiftUI

struct ModifyDirectionsView: View {
    @Binding var directions: [Direction]
    
    @State var newDirection = Direction()
    
    var body: some View {
        VStack {
            let addNewDirectionsView = ModifyDirectionView(direction: $newDirection) { direction in
                    directions.append(direction)
                    newDirection = Direction()
            }.navigationTitle("Add direction")
            
            if directions.isEmpty {
                Spacer()
                NavigationLink("Add new direction", destination: addNewDirectionsView)
                Spacer()
            } else {
                HStack {
                    Text("Directions")
                        .font(.title)
                        .padding()
                    
                    Spacer()
                }
                
                List {
                    ForEach(directions.indices, id: \.self) { index in
                        let direction = directions[index]
                        let editDirectionView = ModifyDirectionView(
                            direction: $directions[index]) { _ in
                                return
                            }.navigationTitle("Edit Directions")
                        
                        NavigationLink(
                            destination: editDirectionView,
                            label: {
                                Text(direction.description)
                            }
                        )
                    }
                    .onDelete {directions.remove(atOffsets: $0)}
                    .onMove {indices, newOffet in directions.move(fromOffsets: indices, toOffset: newOffet)}
                    .listRowBackground(UIConstants.mainColor)
                    
                    NavigationLink(
                        "Add another direction",
                        destination: addNewDirectionsView
                    )
                    .listRowBackground(UIConstants.mainColor)
                    .foregroundColor(UIConstants.listRowFontColor)
                }

            }
        }
    }
}

struct ModifyDirectionsView_Previews: PreviewProvider {
    @State static var directions = Recipe.mockedRecipes[0].directions
    @State static var emptyDirections = [Direction]()
    static var previews: some View {
        NavigationView {
            ModifyDirectionsView(directions: $directions)
        }
        
        NavigationView {
            ModifyDirectionsView(directions: $emptyDirections)
        }
    }
}
