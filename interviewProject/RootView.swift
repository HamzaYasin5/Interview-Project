//
//  RootView.swift
//  interviewProject
//
//  Created by hamza yasin on 20/06/2025.
//

import SwiftUI

enum Language: String, CaseIterable, Identifiable {
    case english = "English"
    case arabic = "العربية"
    var id: String { self.rawValue }
}

struct RootView: View {
    @State private var showMenu = false
    @State private var selectedLanguage: Language = .english

    var body: some View {
        let isRTL = selectedLanguage == .arabic
        GeometryReader { geometry in
            let menuWidth: CGFloat = geometry.size.width * 0.6
            ZStack {
                LinearGradient(colors: [Color.purple, Color.black],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                SideMenuView(selectedLanguage: $selectedLanguage)
                    .frame(width: menuWidth)
                    .offset(x: isRTL ? (showMenu ? 0 : menuWidth) : (showMenu ? 0 : -menuWidth))
                    .position(x: isRTL ? geometry.size.width - menuWidth / 2 : menuWidth / 2, y: geometry.size.height / 2)
                    .opacity(showMenu ? 1 : 0)

                ContentView(showMenu: $showMenu, selectedLanguage: selectedLanguage)
                    .frame(height: showMenu ? geometry.size.height * 0.8 : nil)
                    .cornerRadius(showMenu ? 20 : 0)
                    .padding(.vertical, showMenu ? 32 : 0)
                    .clipped()
                    .overlay(
                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture {
                                showMenu = false
                            }
                            .allowsHitTesting(showMenu)
                    )
                    .offset(x: showMenu ? (isRTL ? -menuWidth : menuWidth) : 0)
                    .scaleEffect(showMenu ? 0.95 : 1)
                    .shadow(color: showMenu ? Color.black.opacity(0.3) : .clear, radius: 10)
                    .ignoresSafeArea(.all, edges: showMenu ? [] : .all)
            }
            .animation(.spring(response: 0.55, dampingFraction: 0.8), value: showMenu)
            .animation(.easeInOut, value: selectedLanguage)
        }
    }
}

