//
//  WelcomeScreenView.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-27.
//

import SwiftUI

struct WelcomeScreenView: View {
    var body: some View {
        NavigationView {
            ZStack {
                UIConstants.mainColor.ignoresSafeArea()
                VStack {
                    HStack {
                        Text("Recipe Book")
                            .bold()
                            .font(.system(size: UIConstants.navigationTitleFontSize))
                            .padding()
                            .frame(
                                width: .infinity,
                                alignment: .center
                            )
                    }
                    
                    Text("Keep your important recipes at hand!")
                        .bold()
                        .frame(
                            maxWidth: .infinity,
                            alignment: .center
                        )
                    
                    Image("HomeScreen")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(30)
                    
                    Button(
                        action: {
                            
                        }, label: {
                            HStack {
                               
                                Text("Get started!")
                                    .foregroundColor(UIConstants.fontColor)
                                    .bold()
                                    
                            }
                           
                        }
                    )
                    .padding()
                    .background(.white)
                    .clipShape(Capsule())
                    
                    
                }
                .foregroundColor(.white)
                .navigationBarHidden(true)
            }
        }
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
    }
}
