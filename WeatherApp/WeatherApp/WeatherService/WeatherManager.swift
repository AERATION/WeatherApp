
import Foundation
import CoreLocation
import Combine

protocol WeatherServiceProtocol {
    var vm: WeatherViewModel? { get set }
    func getCurrentWeather(location: Location)
    func getCurrentWeather(city: String)
}

final class WeatherManager: WeatherServiceProtocol {
    static let shared = WeatherManager()
    var vm: WeatherViewModel? = nil
    private var cancellable = Set<AnyCancellable>()
    
    func getCurrentWeather(city: String) {
        let url = URL(string: APIConfig.getCurrentWeatherByCity(city: city))!
        
        let publisher = URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: CurrentWeather.self, decoder: JSONDecoder())
            .sink(receiveCompletion:{ res in
                print(res)
            }, receiveValue: { [weak self] response in
                self?.vm?.weather = response
            })
            .store(in: &cancellable)
    }
    
    func getCurrentWeather(location: Location) {
        let url = URL(string: APIConfig.getCurrentWeatherByCoordinate(location: location))!
        
        let publisher = URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: CurrentWeather.self, decoder: JSONDecoder())
            .sink(receiveCompletion:{ res in
                print(res)
            }, receiveValue: { [weak self] response in
                self?.vm?.weather = response
            })
            .store(in: &cancellable)
    }
}

