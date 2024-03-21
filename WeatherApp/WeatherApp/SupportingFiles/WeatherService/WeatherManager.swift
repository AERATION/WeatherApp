
import Foundation
import Combine

protocol WeatherServiceProtocol {
    func getCurrentWeather(location: Location) -> AnyPublisher<Weather, Error>
    func getCurrentWeather(city: String) -> AnyPublisher<Weather, Error>
}

final class WeatherManager: WeatherServiceProtocol {
    
    static let shared = WeatherManager()
    private var cancellable = Set<AnyCancellable>()
    
    func getCurrentWeather(city: String) -> AnyPublisher<Weather, Error> {
        let url = URL(string: APIConfig.getWeatherByCity(city: city))!
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
        
        return publisher
            .tryMap { data, response in
                return try JSONDecoder ().decode(Weather.self, from: data)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getCurrentWeather(location: Location) -> AnyPublisher<Weather, Error> {
        let url = URL(string: APIConfig.getWeatherByCoordinate(location: location))!
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
        
        return publisher
            .tryMap { data, response in
                return try JSONDecoder ().decode(Weather.self, from: data)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

