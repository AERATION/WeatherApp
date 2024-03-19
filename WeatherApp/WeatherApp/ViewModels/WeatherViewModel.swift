
import UIKit
import Foundation

final class WeatherViewModel: ObservableObject {
    
    @Published var current: Current = Current(dateEpoch: 0, tempC: 0, condition: Condition(text: "", icon: "", code: 2), humidity: 2)
    @Published var location: Loc = Loc(name: "", lat: 1, lon: 2)
    @Published var weatherImage: UIImage? = UIImage(systemName: "questionmark.circle.fill")
    @Published var city: String = ""
    
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
//        self.current = Current(dateEpoch: 0, tempC: 0, condition: Condition(text: "", icon: "", code: 2), humidity: 2)
//        self.location = Loc(name: "", lat: 1, lon: 2)
        getCurrentWeather()
    }
    
    func onSearchIconTapped() {
        DispatchQueue.main.async {
            self.service.getCurrentWeather(city: self.city)
        }
    }
    
    func getCurrentWeather() {
        LocationManager.shared.getCurrentLocation { location in
            let newLocation: Location = Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.service.getCurrentWeather(location: newLocation)
        }
        
    }
    
    
}
