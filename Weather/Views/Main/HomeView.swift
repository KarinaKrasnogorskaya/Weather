//
//  HomeView.swift
//  Weather
//
//  Created by Карина on 09.03.2023.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83 // это при открытие экрана 702/844 относительно
    case middle = 0.385 // высота части, которая будет занимать пол экрана относительно всего экрана 385/844
}

struct HomeView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    @State var hasDragged: Bool = false
    
    var bottonSheetTranslationProrated: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screeHeght = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screeHeght + 36
                
                ZStack {
                    // MARK: Background
                    Color.background
                        .ignoresSafeArea()
                    
                    // MARK: Image background
                    Image("Background")
                        .resizable() // адаптируется к размеру
                        .ignoresSafeArea()
                        .offset(y: -bottonSheetTranslationProrated * imageOffset )
                    
                    //MARK: House background
                    Image("House")
                        .frame(maxWidth: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottonSheetTranslationProrated * imageOffset )
                    
                    VStack (spacing: -10 * (1 - bottonSheetTranslationProrated)) {
                        
                        Text("Sant-Peterburg")
                            .font(.largeTitle)
                        
                        VStack {
                            
                            Text(attributedString)
                            Text("H:24°  L:18°")
                                .font(.title3.weight(.semibold))
                                .opacity(1 - bottonSheetTranslationProrated)
                            
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.top, 51)
                    .offset(y: -bottonSheetTranslationProrated * 46)
                    
                    //MARK: Bottom Sheet
                    
                    BottomSheetView(position: $bottomSheetPosition) {
                     //   Text(bottonSheetTranslationProrated.formatted())
                    } content: {
                        ForecastView(bottonSheetTranslationProrated : bottonSheetTranslationProrated)
                    }
                    .onBottomSheetDrag { translation in
                        bottomSheetTranslation = translation / screeHeght
                        
                        withAnimation(.easeIn) {
                            if bottomSheetPosition == BottomSheetPosition.top {
                                hasDragged = true
                            } else {
                                hasDragged = false
                            }
                        }
                       
                    }
                    
                    
                    
                    
                    
                    //MARK: Tab Bar
                    TabBar(action: {
                        bottomSheetPosition = .top
                    })
                    .offset(y: bottonSheetTranslationProrated * 115)
                }
            }
                .toolbar(.hidden)
            }
        }


    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + (hasDragged ? " | " : "\n") + "Motly Clear")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: (96 - (bottonSheetTranslationProrated * (96 - 20))), weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottonSheetTranslationProrated)
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
