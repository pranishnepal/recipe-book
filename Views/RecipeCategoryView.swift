//
//  RecipeCategoryView.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-27.
//

import SwiftUI

struct RecipeCategoryView: View {
    /* First Child that uses the ViewModel */
    @StateObject private var recipeViewModel = RecipeViewModel()
    let gridColumns = [GridItem(), GridItem()]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(
                    columns: gridColumns,
                    content: {
                        ForEach(RecipeInformation.Category.allCases, id: \.self) { currCategory in
                            NavigationLink(
                                destination: {
                                    RecipeListView(category: currCategory)
                                        .environmentObject(recipeViewModel)
                                },
                                label: {
                                    CategoryView(category: currCategory)
                                }
                            )
                        }
                    }
                )
            }
            .navigationTitle("Categories")
            .padding()
           
        }
        
    }
}

struct RecipeCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategoryView()
    }
}
