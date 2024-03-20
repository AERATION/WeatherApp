
import UIKit
import Foundation

final class WeatherViewModel: ObservableObject {
    
    private var service: WeatherServiceProtocol
    
    @Published var city: String = ""
    @Published var collectionHourly: [Hour] = []
    @Published var collectionDaily: [Forecastday] = []
    
    var current: Current = Current(dateEpoch: 0, tempC: 0, condition: Condition(text: "", icon: "", code: 0), humidity: 0)
    
//    var current: Current? = nil
    
    var location: Location = Location(name: "", lat: 1, lon: 2)
//    var location: Location? = nil
    
    var weather: Weather? = nil {
        didSet {
            if let weather {
                collectionHourly = weather.forecast.forecastday.first!.hour
                collectionDaily = weather.forecast.forecastday
                current = weather.current
                location = weather.location
            }
        }
    }
    
    //MARK: - Init
    init(service: WeatherServiceProtocol = WeatherManager.shared) {
        self.service = service
        self.service.vm = self
        getCurrentWeather()
    }
    
    //MARK: - Functions
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
