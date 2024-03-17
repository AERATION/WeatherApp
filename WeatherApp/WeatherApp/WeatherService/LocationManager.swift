
import CoreLocation
import Foundation

final class LocationManager: NSObject, CLLocationManagerDelegate  {
    
    private let manager = CLLocationManager()

    static let shared = LocationManager()

    private var locationFetchCompletion: ((CLLocation) -> Void)?

    private var location: CLLocation? {
        didSet {
            guard let location else {
                return
            }
            locationFetchCompletion?(location)
        }
    }

    public func getCurrentLocation(completion: @escaping (CLLocation) -> Void) {

        self.locationFetchCompletion = completion

        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }

    // MARK: - Location

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.location = location
        manager.stopUpdatingLocation()
    }
    
//    static let shared = LocationManager()
//    
//    let locationManager = CLLocationManager()
//    var currentLocation: CLLocation?
//    
//    func setupLocation() {
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if !locations.isEmpty, currentLocation == nil  {
//            currentLocation = locations.first
//            locationManager.stopUpdatingLocation()
//            requestWeatherForLocation()
//        }
//    }
//
//    func requestWeatherForLocation() -> Location {
//        guard let currentLocation = currentLocation else {
//            return Location(latitude: 0, longitude: 0)
//        }
//       
//        return Location(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
//
//    }

}

