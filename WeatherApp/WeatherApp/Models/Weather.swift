
import Foundation


//MARK: - Weather
struct Weather: Codable {
    let location: Loc
    let current: Current
    let forecast: Forecast
}

//MARK: - Current
struct Current: Codable {
    let dateEpoch: Int
    let tempC: Double
    let condition: Condition
    let humidity: Double

    enum CodingKeys: String, CodingKey {
        case dateEpoch = "last_updated_epoch"
        case tempC = "temp_c"
        case condition
        case humidity
    }
}

//MARK: - Condition
struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}

//MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]
}

//MARK: - Forecastday
struct Forecastday: Codable {
    let date: String
    let dateEpoch: Int
    let day: Day
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, hour
    }
}

//MARK: - Day
struct Day: Codable {
    let maxtempC, mintempC: Double
    let avgtempC: Double
    let avghumidity: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case avgtempC = "avgtemp_c"
        case avghumidity
        case condition
    }
}

//MARK: - Hour
struct Hour: Codable {
    let timeEpoch: Int
    let time: String
    let tempC: Double
    let condition: Condition
    

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case tempC = "temp_c"
        case condition
        case time
    }
}

//MARK: - Location
struct Loc: Codable {
    let name: String
    let lat, lon: Double
}

//struct City: Codable {
//    let name: String
//}
//
//struct CurrentWeather: Codable {
//    let wind: Wind
//    let main: Main
//    let clouds: Clouds
//    let weather: [Weather]
//    let name: String
//}
//
//struct Weather: Codable {
//    let main, icon, description: String
//}
//
//struct Main: Codable {
//    let humidity: Int?
//    let tempMin, tempMax, temp: Double
//    
//    enum CodingKeys: String, CodingKey {
//        case humidity
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//        case temp
//    }
//}
//
//struct Clouds: Codable {
//    let all: Int
//}
//
//struct Wind: Codable {
//    let speed: Double?
//}
