import Combine
import UIKit
import Foundation

final class WeatherViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var city: String = ""
    
    @Published var weather: Weather? = nil
    
    var collectionHourly: [Hour] = []
    
    var collectionDaily: [Forecastday] = []
    
    var current: Current = Current(dateEpoch: 0, tempC: 0, condition: Condition(text: "", icon: ""))
    
    var location: Location = Location(name: "", lat: 0, lon: 0)
    
    let weatherManager: WeatherManager = WeatherManager()
    
    private var subscriptions = Set<AnyCancellable>()
    
    private var service: WeatherServiceProtocol
    
    //MARK: - Init
    init(service: WeatherServiceProtocol = WeatherManager.shared) {
        self.service = service
        getCurrentWeather()
        
    }
    
    //MARK: - Functions
    func onSearchIconTapped() {
        service.getCurrentWeather(city: self.city)
            .sink { [weak self] value in
                switch(value) {
                    case .finished:
                        break
                case .failure(let error):
                    print(error)
                
                }
            } receiveValue: { [weak self] response in
                self?.weather = response
                self?.current = response.current
                self?.location = response.location
                self?.collectionDaily = response.forecast.forecastday
                self?.collectionHourly = response.forecast.forecastday.first!.hour
            }
            .store(in: &self.subscriptions)
    }
    
    func getCurrentWeather() {
        LocationManager.shared.getCurrentLocation { location in
            let newLocation: Location = Location(name: "", lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            self.service.getCurrentWeather(location: newLocation)
                .sink { [weak self] value in
                    switch(value) {
                        case .finished:
                            break
                        case .failure(let error):
                            print(error)
                    
                    }
                } receiveValue: { [weak self] response in
                    self?.weather = response
                    self?.current = response.current
                    self?.location = response.location
                    self?.collectionDaily = response.forecast.forecastday
                    self?.collectionHourly = response.forecast.forecastday.first!.hour
                }
                .store(in: &self.subscriptions)
        }
    }
    
    
}
