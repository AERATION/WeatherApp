
import Foundation

struct CurrentWeather: Codable {
    let wind: Wind
    let main: Main
    let clouds: Clouds
    let weather: [Weather]
    let name: String
}

struct Weather: Codable {
    let main, icon, description: String
}

struct Main: Codable {
    let humidity: Int?
    let tempMin, tempMax, temp: Double
    
    enum CodingKeys: String, CodingKey {
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case temp
    }
}

struct Clouds: Codable {
    let all: Int
}

struct Wind: Codable {
    let speed: Double?
}
