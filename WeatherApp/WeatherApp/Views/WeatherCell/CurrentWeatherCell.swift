
import Foundation
import UIKit
import Kingfisher

final class CurrentWeatherCell: UICollectionViewCell {
    
    static let identifier = "CurrentWeatherCell"
    
    var searchIconTapedAction: (() -> ())?
    var locationIconTapedAction: (() -> ())?
    
    private let cityTextField: UITextField = {
        let textField = UITextField()
        
        return textField
    } ()
    
    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UR.Images.imageSearch
        imageView.tintColor = .black
        return imageView
    } ()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UR.Images.imageLocation
        imageView.tintColor = .black
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
        image.image = UIImage(systemName: "sun.max")
        return image
    } ()
    
    private let currentTempLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UR.Fonts.tempFont
        return label
    } ()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UR.Fonts.conditionFont
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(searchImageView)
        self.addSubview(locationImageView)
        self.addSubview(currentCityLabel)
        self.addSubview(currentDateLabel)
        self.addSubview(weatherImage)
        self.addSubview(currentTempLabel)
        self.addSubview(conditionLabel)
        addTargets()
        makeConstrains()
    }
    
    private func addTargets() {
        let searchTapped = UITapGestureRecognizer(target: self, action: #selector(searchTapped(tapGestureRecognizer:)))
        searchImageView.isUserInteractionEnabled = true
        searchImageView.addGestureRecognizer(searchTapped)
        
        let locationTapped = UITapGestureRecognizer(target: self, action: #selector(locationTapped(tapGestureRecognizer:)))
        locationImageView.isUserInteractionEnabled = true
        locationImageView.addGestureRecognizer(locationTapped)
    }
    
    @objc func searchTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        searchIconTapedAction?()
    }
    
    @objc func locationTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        locationIconTapedAction?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currentCityLabel.text = nil
        weatherImage.image = nil
        currentTempLabel.text = nil
        conditionLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
        currentTempLabel.snp.makeConstraints { make in
            make.top.equalTo(currentCityLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(42)
        }
        
        conditionLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTempLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(42)
        }
        
        weatherImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(conditionLabel.snp.bottom).offset(-16)
            make.height.equalTo(128)
            make.width.equalTo(128)
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
    
    func configureCell(for current: Current, location: Location) {
        currentTempLabel.text = "\(String(Int(current.tempC))) °C"
        currentCityLabel.text = location.name
        let newUrl = current.condition.icon.replacingOccurrences(of: "64x64", with: "128x128", options: NSString.CompareOptions.literal, range: nil)
        let url = URL(string: "https:\(newUrl)")
        conditionLabel.text = current.condition.text
        weatherImage.kf.setImage(with: url)
    }
    
}
