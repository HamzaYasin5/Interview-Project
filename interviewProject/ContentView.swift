//
//  ContentView.swift
//  interviewProject
//
//  Created by hamza yasin on 20/06/2025.
//

import SwiftUI

struct ContentView: View {
    @Binding var showMenu: Bool
    var selectedLanguage: Language

    var body: some View {
        ZStack {
            WeatherView(showMenu: showMenu)
            VStack {
                HStack {
                    if selectedLanguage == .english {
                        Button(action: {
                            withAnimation {
                                showMenu.toggle()
                            }
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                        .padding(.top, 50)
                        .padding(.leading)
                        Spacer()
                    } else {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showMenu.toggle()
                            }
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                        .padding(.top, 50)
                        .padding(.trailing)
                    }
                }
                Spacer()
            }
        }
    }
}

