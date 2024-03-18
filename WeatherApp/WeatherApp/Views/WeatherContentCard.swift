
import UIKit
import Foundation
import SnapKit
import Combine

class WeatherContentView: UIView {
    
    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UR.Images.imageSearch
        return imageView
    } ()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UR.Images.imageLocation
        return imageView
    } ()
    
    private let currentDateLabel: UILabel = {
        let label = UILabel()
        let currentData = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        label.text = formatter.string(from: currentData)
        return label
    } ()
    
    private let currentCityLabel: UILabel = {
        let label = UILabel()
        label.text = "Moscow"
        label.font = UR.Fonts.cityFont
        return label
    } ()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        return image
    } ()
    
    private let currentTempLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.font = UR.Fonts.tempFont
        return label
    } ()
    
    private let minMaxTempLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        return label
    } ()
    
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: WeatherViewModel = WeatherViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
        connectViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.layer.cornerRadius = 40
        self.backgroundColor = .white
        self.addSubview(searchImageView)
        self.addSubview(locationImageView)
        self.addSubview(currentCityLabel)
        self.addSubview(currentDateLabel)
        self.addSubview(currentTempLabel)
        self.addSubview(minMaxTempLabel)
        self.addSubview(weatherImage)
        makeConstrains()
    }
    
    private func connectViewModel() {
//        viewModel.getCurrentWeather()
        
        viewModel.$cityName
            .sink { [weak self] cityName in
                self?.currentCityLabel.text = cityName
            }
            .store(in: &subscriptions)
        
        viewModel.$temp
            .sink { [weak self] temp in
                self?.currentTempLabel.text = "\(temp)℃"
            }
            .store(in: &subscriptions)
        viewModel.$maxMinTemp
            .sink { [weak self] resp in
                self?.minMaxTempLabel.text = resp
            }
            .store(in: &subscriptions)
        viewModel.$weatherImage
            .sink { [weak self] weatherImage in
                self?.weatherImage.image = weatherImage
            }
            .store(in: &subscriptions)
    }
    
    private func makeConstrains() {
        currentDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UR.Constraints.currentDateLeading)
            make.top.equalToSuperview().offset(UR.Constraints.currentDateTop)
            make.height.equalTo(UR.Constraints.currentDateHeight)
        }
        
        currentCityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(UR.Constraints.currentCityTop)
            make.height.equalTo(UR.Constraints.currentCityHeight)
        }
        
        weatherImage.snp.makeConstraints { make in
            make.top.equalTo(currentTempLabel.snp.top)
            make.trailing.equalTo(currentTempLabel.snp.leading).offset(-16)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        currentTempLabel.snp.makeConstraints { make in
            make.top.equalTo(currentCityLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(42)
        }
        
        minMaxTempLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTempLabel.snp.bottom).offset(16)
            make.center.equalToSuperview()
            make.height.equalTo(42)
        }
        
        searchImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UR.Constraints.searchImageLeading)
            make.bottom.equalToSuperview().offset(UR.Constraints.searchImageBottom)
            make.height.equalTo(UR.Constraints.searchImageHeight)
            make.width.equalTo(UR.Constraints.searchImageWidth)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(UR.Constraints.locationImageTrailing)
            make.bottom.equalToSuperview().offset(UR.Constraints.locationImageBottom)
            make.height.equalTo(UR.Constraints.locationImageHeight)
            make.width.equalTo(UR.Constraints.locationImageWidth)
        }
    }
    
}
