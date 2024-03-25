
struct APIConfig {

    static let apiKey = "6bebf4cc854b4d1fbeb163537241703"
    static let endPoint = "https://api.weatherapi.com/v1/forecast.json?"
    static let days = "7"
    
    static func getWeatherByCoordinate(location: Location) -> String {
        return "\(endPoint)key=\(apiKey)&q=\(location.lat),\(location.lon)&days=\(days)&aqi=no&alerts=no"
    }
    
    static func getWeatherByCity(city: String) -> String {
        return "\(endPoint)key=\(apiKey)&q=\(city)&days=\(days)&aqi=no&alerts=no"
    }
}
