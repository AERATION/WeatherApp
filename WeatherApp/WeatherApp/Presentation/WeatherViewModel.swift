
import UIKit
import Foundation

final class WeatherViewModel: ObservableObject {
    private var service: WeatherServiceProtocol
    
    var weather: CurrentWeather? = nil {
        didSet {
            if let weather {
                temp = "\(weather.main.temp)"
                maxMinTemp = "\(weather.main.tempMax)℃/\(weather.main.tempMin)℃"
                cityName = weather.name
                print(temp)
                print(cityName)
                print(maxMinTemp)
                let image = {
                    switch weather.weather.first?.icon {
                        case "01d": return UIImage(systemName: "sun.max")
                        case "01n": return UIImage(systemName: "moon")
                        case "02d": return UIImage(systemName: "cloud.sun")
                        case "02n": return UIImage(systemName: "cloud.moon")
                        case "03d", "03n", "04d", "04n": return UIImage(systemName: "cloud")
                        case "09d", "09n": return UIImage(systemName: "cloud.rain")
                        case "10d": return UIImage(systemName: "cloud.sun.rain")
                        case "10n": return UIImage(systemName: "cloud.moon.rain")
                        case "11d", "11n": return UIImage(systemName: "cloud.bolt.rain")
                        case "13d", "13n": return UIImage(systemName: "cloud.snow")
                        case "50d", "50n": return UIImage(systemName: "cloud.fog")
                        default: return UIImage(systemName: "questionmark.circle.fill")
                    }
                }
            }
        }
    }
    
    @Published var icon: String = ""
    @Published var temp: String = ""
    @Published var maxMinTemp: String = ""
    @Published var cityName: String = "..."
    @Published var weatherImage: UIImage? = UIImage(systemName: "questionmark.circle.fill")
    
//    var location: Location = LocationManager().requestWeatherForLocation()
    
    init(service: WeatherServiceProtocol = WeatherManager.shared) {
        self.service = service
        self.service.vm = self
        getCurrentWeather()
    }
    
    func getCurrentWeatherFor(city: String) {
        service.getCurrentWeather(city: city)
    }
    
    func getCurrentWeather() {
        LocationManager.shared.getCurrentLocation { location in
            let newLocation: Location = Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.service.getCurrentWeather(location: newLocation)
            print(newLocation.latitude)
            print(newLocation.longitude)
        }
        
    }
    
    
}
