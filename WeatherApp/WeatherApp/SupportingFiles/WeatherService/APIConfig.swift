
import Foundation

struct Location {
    let latitude: Double
    let longitude: Double
}

struct APIConfig {
    static let apiKey = "6bebf4cc854b4d1fbeb163537241703"
    static let endPoint = "https://api.weatherapi.com/v1/forecast.json?"
    
    static func getWeatherByCoordinate(location: Location) -> String {
        return "\(endPoint)key=\(apiKey)&q=\(location.latitude),\(location.longitude)&days=3&aqi=no&alerts=no"
    }
    
    static func getWeatherByCity(city: String) -> String {
        return "\(endPoint)key=\(apiKey)&q=\(city)&days=3&aqi=no&alerts=no"
    }
//
//    static func getCurrentWeatherByCoordinate(location: Location) -> String {
//        return "\(endPoint)weather?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(apiKey)&units=metric"
//    }
//    
//    static func getCurrentWeatherByCity(city: String) -> String {
//        return "\(endPoint)weather?q=\(city)&appid=\(apiKey)&units=metric"
//    }
//    
//    static func getWeatherByCoordinate(location: Location) -> String {
//        return "\(endPoint)forecast?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(apiKey)&units=metric"
//    }
//    
//    static func getWeatherByCity(city: String) -> String {
//        return "\(endPoint)forecast?q=\(city)&appid=\(apiKey)&units=metric"
//    }
}
