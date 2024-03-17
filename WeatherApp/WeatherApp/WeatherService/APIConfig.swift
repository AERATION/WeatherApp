
import Foundation

struct Location {
    let latitude: Double
    let longitude: Double
}

struct APIConfig {
    static let apiKey = "6aa2496e30c05176854f4f0ddee80f19"
    static let endPoint = "https://api.openweathermap.org/data/2.5/"
    
    static func getCurrentWeatherByCoordinate(location: Location) -> String {
        return "\(endPoint)weather?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(apiKey)&units=metric"
    }
    
    static func getCurrentWeatherByCity(city: String) -> String {
        return "\(endPoint)weather?q=\(city)&appid=\(apiKey)&units=metric"
    }
    
    static func getWeatherByCoordinate(location: Location) -> String {
        return "\(endPoint)forecast?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(apiKey)&units=metric"
    }
    
    static func getWeatherByCity(city: String) -> String {
        return "\(endPoint)forecast?q=\(city)&appid=\(apiKey)&units=metric"
    }
}
