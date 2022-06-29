//
//  ModifyDirectionView.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-29.
//

import SwiftUI

struct ModifyDirectionView: View {
    @Binding var direction: Direction
    let performModification: ((Direction) -> Void)
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            TextField("Direction description", text: $direction.description)
                .listRowBackground(UIConstants.mainColor)
            
            Toggle("Optional direction", isOn: $direction.isOptional)
                .listRowBackground(UIConstants.mainColor)
            
            HStack {
                Spacer()
                Button(
                    action: {
                        performModification(direction)
                        presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Text("Save")
                    }
                )
                Spacer()
            }
            .listRowBackground(UIConstants.mainColor)
        }
    }
}

struct ModifyDirectionView_Previews: PreviewProvider {
    @State static var emptyDirection = Direction(description: "", isOptional: false)
    static var previews: some View {
        ModifyDirectionView(direction: $emptyDirection) { _ in
            return
        }
    }
}
