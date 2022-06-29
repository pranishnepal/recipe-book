//
//  CategoryView.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-27.
//

import SwiftUI

struct CategoryView: View {
    let category: RecipeInformation.Category
    
    var body: some View {
        ZStack {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.5)
            
            Text(category.rawValue)
                .bold()
                .font(.largeTitle)
                .foregroundColor(UIConstants.fontColor)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let category = RecipeInformation.Category.lunch
        CategoryView(category: category)
    }
}
