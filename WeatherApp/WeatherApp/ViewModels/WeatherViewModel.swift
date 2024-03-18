
import UIKit
import Foundation

final class WeatherViewModel: ObservableObject {
    private var service: WeatherServiceProtocol
    
    var collectionHourlyVM = HourlyWeatherViewModel()
    var collectionDailyVM = DailyWeatherViewModel()
    
    var weather: Weather? = nil {
        didSet {
            if let weather {
                temp = "\(weather.current.tempC)"
                cityName = weather.location.name
                collectionDailyVM.forecastDays = weather.forecast.forecastday
                collectionHourlyVM.hours = weather.forecast.forecastday.first!.hour
                current = weather.current
                location = weather.location
//                print("Forecast: \(weather.forecast.forecastday)")
//                print("Hourst: \(weather.forecast.forecastday.first!.hour) ")
//                print("Temp: \(temp)")
//                let image = {
//                    switch weather.weather.first?.icon {
//                        case "01d": return UIImage(systemName: "sun.max")
//                        case "01n": return UIImage(systemName: "moon")
//                        case "02d": return UIImage(systemName: "cloud.sun")
//                        case "02n": return UIImage(systemName: "cloud.moon")
//                        case "03d", "03n", "04d", "04n": return UIImage(systemName: "cloud")
//                        case "09d", "09n": return UIImage(systemName: "cloud.rain")
//                        case "10d": return UIImage(systemName: "cloud.sun.rain")
//                        case "10n": return UIImage(systemName: "cloud.moon.rain")
//                        case "11d", "11n": return UIImage(systemName: "cloud.bolt.rain")
//                        case "13d", "13n": return UIImage(systemName: "cloud.snow")
//                        case "50d", "50n": return UIImage(systemName: "cloud.fog")
//                        default: return UIImage(systemName: "questionmark.circle.fill")
//                    }
//                } ()
//                weatherImage = image
            }
        }
    }
    @Published var current: Current = Current(dateEpoch: 0, tempC: 0, condition: Condition(text: "", icon: "", code: 2), humidity: 2)
    @Published var location: Loc = Loc(name: "", lat: 1, lon: 2)
    @Published var icon: String = ""
    @Published var temp: String = ""
    @Published var maxMinTemp: String = ""
    @Published var cityName: String = "..."
    @Published var weatherImage: UIImage? = UIImage(systemName: "questionmark.circle.fill")
    
    init(service: WeatherServiceProtocol = WeatherManager.shared) {
        self.service = service
        self.service.vm = self
        self.collectionDailyVM = DailyWeatherViewModel()
        self.collectionHourlyVM = HourlyWeatherViewModel()
//        self.current = Current(dateEpoch: 0, tempC: 0, condition: Condition(text: "", icon: "", code: 2), humidity: 2)
//        self.location = Loc(name: "", lat: 1, lon: 2)
        getCurrentWeather()
    }
    
    func getCurrentWeatherFor(city: String) {
        service.getCurrentWeather(city: city)
    }
    
    func getCurrentWeather() {
        LocationManager.shared.getCurrentLocation { location in
            let newLocation: Location = Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.service.getCurrentWeather(location: newLocation)
        }
        
    }
    
    
}
