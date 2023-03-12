//
//  WeatherView.swift
//  Weather
//
//  Created by Карина on 12.03.2023.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        ZStack {
            //MARK: Background
            Color.background
                .ignoresSafeArea()
        }
        .overlay {
            //MARK: Navigation Bar
            NavigationBar()
        }
        .toolbar(.hidden)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .preferredColorScheme(.dark)
    }
}
