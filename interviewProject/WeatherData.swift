import Foundation
import Combine

// MARK: - Weather Data Models

/// Top-level API response structure
struct ApiResponse: Codable {
    let Response: WeatherResponse
}

/// Weather API response containing status and data
struct WeatherResponse: Codable {
    let status: Bool
    let message: String
    let result: WeatherData
}

/// Core weather data model matching the API JSON structure
struct WeatherData: Codable {
    let city: String
    let dateTime: String
    let weather_icon: String
    let temp: Double
    let unit: String
    let weather: String
    let feels_like: String
    let high: Double
    let low: Double
    let humi: String
    let wind_direction: String
    let wind_speed: Int
    let wind_speed_unit: String
}

// MARK: - Weather View Model

/// Observable view model for managing weather data fetching and state
class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    @Published var isLoading = false
    @Published var error: String?

    /// Weather API endpoint URL
    private let url = URL(string: "https://raw.githubusercontent.com/Krishnarajsalim/JSON/main/weather.json")!

    /// Fetches weather data from the API
    func fetchWeather() {
        isLoading = true
        error = nil
        
        print("🌤️ Fetching weather data...") // Debug print
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let err = err {
                    print("❌ Network error: \(err.localizedDescription)")
                    self.error = err.localizedDescription
                    return
                }
                
                guard let data = data else {
                    print("❌ No data received")
                    self.error = "No data received"
                    return
                }
                
                do {
                    let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                    if apiResponse.Response.status {
                        print("✅ Weather data loaded successfully")
                        self.weatherData = apiResponse.Response.result
                    } else {
                        print("❌ API error: \(apiResponse.Response.message)")
                        self.error = apiResponse.Response.message
                    }
                } catch {
                    print("❌ JSON Decoding Error:")
                    print(error)
                    print("---------------------------")
                    self.error = "Failed to decode weather data. Check console for details."
                }
            }
        }.resume()
    }
    
    // TODO: Add caching mechanism for offline support
    // TODO: Implement retry logic for failed requests
} 