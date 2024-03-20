
import UIKit
import Foundation

final class WeatherViewModel: ObservableObject {
    
    @Published var city: String = ""
    
    
    var current: Current = Current(dateEpoch: 0, tempC: 0, condition: Condition(text: "", icon: "", code: 2), humidity: 2)
    var location: Location = Location(name: "", lat: 1, lon: 2)
    private var service: WeatherServiceProtocol
    
    var collectionHourlyVM = HourlyWeatherViewModel()
    var collectionDailyVM = DailyWeatherViewModel()
    
    var weather: Weather? = nil {
        didSet {
            if let weather {
                collectionDailyVM.forecastDays = weather.forecast.forecastday
                collectionHourlyVM.hours = weather.forecast.forecastday.first!.hour
                current = weather.current
                location = weather.location
            }
        }
    }
    
    init(service: WeatherServiceProtocol = WeatherManager.shared) {
        self.service = service
        self.service.vm = self
        self.collectionDailyVM = DailyWeatherViewModel()
        self.collectionHourlyVM = HourlyWeatherViewModel()
        getCurrentWeather()
    }
    
    func onSearchIconTapped() {
        service.getCurrentWeather(city: self.city)
    }
    
    func getCurrentWeather() {
        LocationManager.shared.getCurrentLocation { location in
            let newLocation: Location = Location(name: "", lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            self.service.getCurrentWeather(location: newLocation)
        }
    }
    
    
}
