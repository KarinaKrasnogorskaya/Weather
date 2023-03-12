//
//  ForecastView.swift
//  Weather
//
//  Created by Карина on 10.03.2023.
//

import SwiftUI

struct ForecastView: View {
    var bottonSheetTranslationProrated: CGFloat = 1
    
    @State private var  selection: Int = 0
    var body: some View {
        ScrollView() {
            //MARK: Segmented Control
            VStack(spacing: 0) {
                SegmentedControl(selection: $selection)
                
                //MARK: Forecast Cards
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        if selection == 0 {
                            ForEach(Forecast.hourly) { forecast in
                                ForecastCard(forecast: forecast, forecastPeriod: .hourly)
                            }
                            .transition(.offset(x: -430))
                        } else {
                            ForEach(Forecast.weekly) { forecast in
                                ForecastCard(forecast: forecast, forecastPeriod: .weekly)
                            }
                            .transition(.offset(x: 430))
                        }
                    }
                    .padding(.vertical, 12)
                }
                .padding(.horizontal, 20)
                
                //MARK: Forecast Widgest
                
                Image("Forecast Widgets")
                    .opacity(bottonSheetTranslationProrated)
            }
        }
        .backgrondBlur(radius: 25, opaque: true)
        .background(Color.bottomSheetBackground)
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innerShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBorderMiddle, lineWight: 1, offsetX: 0, offsetY: 1, blur: 0, blendMode: .overlay, oposity: 1 - bottonSheetTranslationProrated)
        .overlay {
            
            //MARK: Bottom Sheet Separator
            Divider()
                
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTop)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            //MARK: Drag Indicator
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.3))
                .frame(width: 48, height: 5)
                .frame(height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
            .background(Color.background)
            .preferredColorScheme(.dark)
    }
}
