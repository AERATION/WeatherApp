import Combine
import UIKit
import Foundation

final class WeatherViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var city: String = ""
    
    @Published var weather: Weather? = nil
    
    @Published var loadingState: LoadingState = .none
    
    private let weatherManager: WeatherManager = WeatherManager()
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let service: WeatherServiceProtocol
    
    //MARK: - Init
    init(service: WeatherServiceProtocol = WeatherManager.shared) {
        self.service = service
        getCurrentWeather()
        
    }
    
    //MARK: - Functions
    func onSearchIconTapped() {
        self.loadingState = .loading
        service.getCurrentWeather(city: self.city)
            .sink { value in
                switch(value) {
                    case .finished:
                        self.loadingState = .success
                    case .failure(let error):
                        self.loadingState = .failed
                }
            } receiveValue: { [weak self] response in
                self?.weather = response
            }
            .store(in: &self.subscriptions)
    }
    
    func getCurrentWeather() {
        self.loadingState = .loading
        LocationManager.shared.getCurrentLocation { location in
            let newLocation: Location = Location(name: "", lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            self.service.getCurrentWeather(location: newLocation)
                .sink { value in
                    switch(value) {
                        case .finished:
                            self.loadingState = .success
                        case .failure(let error):
                            self.loadingState = .failed
                    }
                } receiveValue: { [weak self] response in
                    self?.weather = response
                }
                .store(in: &self.subscriptions)
        }
    }
}
