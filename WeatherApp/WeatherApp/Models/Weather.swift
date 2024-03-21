
import Foundation

//MARK: - Weather
struct Weather: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

//MARK: - Current
struct Current: Codable {
    let dateEpoch: Int
    let tempC: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case dateEpoch = "last_updated_epoch"
        case tempC = "temp_c"
        case condition
    }
}

//MARK: - Condition
struct Condition: Codable {
    let text: String
    let icon: String
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
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
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
struct Location: Codable {
    let name: String
    let lat, lon: Double
}
