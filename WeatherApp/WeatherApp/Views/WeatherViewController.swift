import CoreLocation
import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    
    private let newWeather: NewWeather = NewWeather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .darkGray
        view.addSubview(newWeather)
        makeConstraints()
    }
    
    private func makeConstraints() {
        newWeather.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

