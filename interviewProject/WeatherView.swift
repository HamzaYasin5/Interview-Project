//
//  WeatherView.swift
//  interviewProject
//
//  Created by hamza yasin on 20/06/2025.
//

import SwiftUI

/// Formats timestamp string from API to readable date format
private func formatDate(from timestampString: String?) -> String {
    guard let timestampString = timestampString, let timestamp = TimeInterval(timestampString) else { 
        return "Loading..." 
    }
    let date = Date(timeIntervalSince1970: timestamp)
    let formatter = DateFormatter()
    formatter.dateFormat = "E, d MMM, hh:mm a"
    return formatter.string(from: date)
}

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @Environment(\.layoutDirection) var layoutDirection
    var showMenu: Bool = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.9), Color.blue.opacity(0.8)]),
                           startPoint: .top, endPoint: .bottom)
                .applyIgnoresSafeArea(!showMenu)

            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            } else if let weather = viewModel.weatherData {
                VStack {
                    Spacer()

                    VStack(spacing: 0) {
                        // Glassmorphic weather information section
                        VStack(alignment: .leading, spacing: 10) {
                            Text(weather.city)
                                .font(.appFont(language: layoutDirection == .rightToLeft ? .arabic : .english, size: 36))
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text(formatDate(from: weather.dateTime))
                                .font(.appFont(language: layoutDirection == .rightToLeft ? .arabic : .english, size: 16))
                                .foregroundColor(.white.opacity(0.8))

                            HStack(alignment: .center, spacing: 20) {
                                Image(systemName: "sun.max.fill")
                                    .font(.system(size: 70))
                                    .foregroundColor(.yellow)
                                
                                VStack(alignment: .leading) {
                                    Text("\(Int(weather.temp))\(weather.unit)")
                                        .font(.appFont(language: layoutDirection == .rightToLeft ? .arabic : .english, size: 44))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)

                                    Text(weather.weather)
                                        .foregroundColor(.white)
                                        .font(.appFont(language: layoutDirection == .rightToLeft ? .arabic : .english, size: 20))

                                    Text("Feels like \(weather.feels_like)°")
                                        .foregroundColor(.white.opacity(0.8))
                                        .font(.appFont(language: layoutDirection == .rightToLeft ? .arabic : .english, size: 16))
                                }
                            }
                            
                            HStack {
                               Label("H: \(Int(weather.high))°", systemImage: "arrow.up")
                               Label("L: \(Int(weather.low))°", systemImage: "arrow.down")
                            }
                            .font(.appFont(language: layoutDirection == .rightToLeft ? .arabic : .english, size: 16))
                            .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)

                        HStack(spacing: 12) {
                            WeatherInfoItem(icon: "drop.fill", label: "HUMI", value: weather.humi)
                            WeatherInfoItem(icon: "location.north.fill", label: "", value: weather.wind_direction)
                            WeatherInfoItem(icon: "wind", label: "", value: "\(weather.wind_speed) \(weather.wind_speed_unit)")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                    }
                    .cornerRadius(25)
                    .padding(.horizontal)
                    .padding(.top, 12)

                    Spacer()
                    
                    // FIXME: This button doesn't do anything yet - need to implement location picker
                    Circle()
                        .strokeBorder(Color.white.opacity(0.5), lineWidth: 2)
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.white)
                        )
                        .padding(.bottom, 30)
                }
            } else if let error = viewModel.error {
                Text("Failed to load weather: \(error)")
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .onAppear { 
            viewModel.fetchWeather() 
        }
    }
}

/// Individual weather information item component
struct WeatherInfoItem: View {
    var icon: String
    var label: String
    var value: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.callout)
                .foregroundColor(.secondary)
            
            Text(label)
                 .font(.caption)
                 .foregroundColor(.secondary)

            Text(value)
                .font(.headline)
                .foregroundColor(.primary)
        }
    }
}

// MARK: - View Extensions

/// Extension to conditionally apply ignoresSafeArea based on menu state
extension View {
    @ViewBuilder
    func applyIgnoresSafeArea(_ shouldIgnore: Bool) -> some View {
        if shouldIgnore {
            self.ignoresSafeArea()
        } else {
            self
        }
    }
}

// MARK: - Font Extensions

/// Font extension for app-specific typography with language support
extension Font {
    static func appFont(language: Language, size: CGFloat) -> Font {
        let fontName = (language == .english) ? "Effra-Regular" : "Cairo-Regular"
        return .custom(fontName, size: size)
    }
}
