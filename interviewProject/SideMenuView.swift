//
//  SideMenuView.swift
//  interviewProject
//
//  Created by hamza yasin on 20/06/2025.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var selectedLanguage: Language

    private var selectedLanguageIndex: Binding<Int> {
        Binding(
            get: { selectedLanguage == .english ? 0 : 1 },
            set: { newIndex in
                selectedLanguage = newIndex == 0 ? .english : .arabic
            }
        )
    }

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: selectedLanguage == .arabic ? 8 : 20) {
                Spacer().frame(height: 50)

                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 60, height: 60)
                
                Text(selectedLanguage == .arabic ? "القائمة" : "MENU")
                    .font(.appFont(language: selectedLanguage, size: 14))
                    .foregroundColor(.yellow)
                    .multilineTextAlignment(selectedLanguage == .arabic ? .trailing : .leading)
                
                ForEach(menuItems.indices, id: \.self) { i in
                    Text(selectedLanguage == .arabic ? menuItemsArabic[i] : menuItems[i])
                        .font(.appFont(language: selectedLanguage, size: 18))
                        .foregroundColor(.white)
                        .multilineTextAlignment(selectedLanguage == .arabic ? .trailing : .leading)
                }

                Spacer()
                
                CustomSegmentedControl(
                    selectedIndex: selectedLanguageIndex,
                    titles: [Language.english.rawValue, Language.arabic.rawValue]
                )
                .frame(width: 160, height: 32)
                .font(.appFont(language: selectedLanguage, size: 14))
                .environment(\.layoutDirection, .leftToRight)
                
                HStack(spacing: 8) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.yellow)
                    Text(selectedLanguage == .arabic ? "شارك التطبيق" : "Share app")
                        .font(.appFont(language: selectedLanguage, size: 18))
                        .foregroundColor(.yellow)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .environment(\.layoutDirection, selectedLanguage == .arabic ? .rightToLeft : .leftToRight)
                .padding(.top)
            }
            .padding(.leading, 12)
            .environment(\.layoutDirection, selectedLanguage == .arabic ? .rightToLeft : .leftToRight)
        }
    }
    
    private var menuItems: [String] {
        [
            "Dashboard", "Weather News", "Rain Radar",
            "Weather Stations", "Notifications Center",
            "Monthly Reports", "Worldwide Cities",
            "About Us", "Settings", "Contact Us", "Disclaimer"
        ]
    }
    
    private var menuItemsArabic: [String] {
        [
            "الرئيسية", "اخبار الطقس", "رادار الأمطار",
            "محطات الطقس", "مركز الإشعارات",
            "تقارير شهرية", "إدارة المدن العالمية",
            "عن التطبيق", "الإعدادات", "اتصل بنا", "إخلاء المسؤولية"
        ]
    }
}



