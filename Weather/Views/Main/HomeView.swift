//
//  HomeView.swift
//  Weather
//
//  Created by Карина on 09.03.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: Background
                Color.background
                    .ignoresSafeArea()
                
                // MARK: Image background
                Image("Background")
                    .resizable() // адаптируется к размеру
                    .ignoresSafeArea()
                
                //MARK: House background
                Image("House")
                    .frame(maxWidth: .infinity, alignment: .top)
                    .padding(.top, 257)
                
                VStack (spacing: -10) {
                    
                    Text("Sant-Peterburg")
                        .font(.largeTitle)
                    
                    VStack {
                        
                        Text(attributedString)
                        Text("H:24°  L:18°")
                            .font(.title3.weight(.semibold))
                        
                    }
                    
                    Spacer()
                      
                }
                .padding(.top, 51)
                
                //MARK: Tab Bar
                TabBar(action: {})
            }
            .toolbar(.hidden)
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + "\n" + "Motly Clear")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: 96, weight:  .thin)
            string[temp].foregroundColor = .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary
        }
        
        if let weather = string.range(of: "Motly Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
