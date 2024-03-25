
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate  {
    
    static let shared = LocationManager()
    
    private let manager = CLLocationManager()

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

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.location = location
        manager.stopUpdatingLocation()
    }
}
