import CoreLocation
import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    
    private let weatherContent: WeatherContentView = WeatherContentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    

    private func configureUI() {
        view.backgroundColor = .darkGray
        view.addSubview(weatherContent)
        makeConstraints()
    }
    
    private func makeConstraints() {
        weatherContent.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UR.Constraints.weatherContentLeading)
            make.trailing.equalToSuperview().offset(UR.Constraints.weatherContentTrailing)
            make.top.equalTo(view.safeAreaInsets.top).offset(UR.Constraints.weatherContentTop)
            make.height.equalTo(UR.Constraints.weatherContentHeight)
        }
    }

}

