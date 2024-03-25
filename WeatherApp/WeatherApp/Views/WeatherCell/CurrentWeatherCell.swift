
import UIKit
import Kingfisher

final class CurrentWeatherCell: UICollectionViewCell {
    
    //MARK: - Identifier
    static let identifier = UR.Constants.CurrentCell.currentIdentifier
    
    //MARK: - Properties
    var searchIconTapedAction: (() -> ())?
    var locationIconTapedAction: (() -> ())?
    
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
        formatter.dateFormat = UR.DateFormat.date
        label.text = formatter.string(from: currentData)
        label.font = UR.Fonts.dateFont
        return label
    } ()
    
    private let currentCityLabel: UILabel = {
        let label = UILabel()
        label.font = UR.Fonts.cityFont
        return label
    } ()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.image = UR.Images.defaultImage
        return image
    } ()
    
    private let currentTempLabel: UILabel = {
        let label = UILabel()
        label.font = UR.Fonts.tempFont
        return label
    } ()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.font = UR.Fonts.conditionFont
        return label
    } ()
    
    //MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addTargets()
        makeConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currentCityLabel.text = nil
        weatherImage.image = nil
        currentTempLabel.text = nil
        conditionLabel.text = nil
    }
    
    //MARK: - Private functions
    private func addSubviews() {
        self.addSubview(searchImageView)
        self.addSubview(locationImageView)
        self.addSubview(currentCityLabel)
        self.addSubview(currentDateLabel)
        self.addSubview(weatherImage)
        self.addSubview(currentTempLabel)
        self.addSubview(conditionLabel)
    }
    
    private func addTargets() {
        let searchTapped = UITapGestureRecognizer(target: self, action: #selector(searchTapped(tapGestureRecognizer:)))
        searchImageView.isUserInteractionEnabled = true
        searchImageView.addGestureRecognizer(searchTapped)
        
        let locationTapped = UITapGestureRecognizer(target: self, action: #selector(locationTapped(tapGestureRecognizer:)))
        locationImageView.isUserInteractionEnabled = true
        locationImageView.addGestureRecognizer(locationTapped)
    }
    
    @objc private func searchTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        searchIconTapedAction?()
    }
    
    @objc private func locationTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        locationIconTapedAction?()
    }

    private func makeConstrains() {
        currentDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UR.Constants.CurrentCell.dateLeading)
            make.top.equalToSuperview().offset(UR.Constants.CurrentCell.dateTop)
            make.height.equalTo(UR.Constants.CurrentCell.dateHeight)
        }
        
        currentCityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(UR.Constants.CurrentCell.cityTop)
            make.height.equalTo(UR.Constants.CurrentCell.cityHeight)
        }
    
        currentTempLabel.snp.makeConstraints { make in
            make.top.equalTo(currentCityLabel.snp.bottom).offset(UR.Constants.CurrentCell.tempLabelTop)
            make.centerX.equalToSuperview()
            make.height.equalTo(UR.Constants.CurrentCell.tempLabelHeight)
        }
        
        conditionLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTempLabel.snp.bottom).offset(UR.Constants.CurrentCell.conditionTop)
            make.centerX.equalToSuperview()
            make.height.equalTo(UR.Constants.CurrentCell.conditionHeight)
        }
        
        weatherImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(conditionLabel.snp.bottom).offset(UR.Constants.CurrentCell.weatherImageTop)
            make.height.equalTo(UR.Constants.CurrentCell.weatherImageHeight)
            make.width.equalTo(UR.Constants.CurrentCell.weatherImageWidth)
        }
        
        searchImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UR.Constants.CurrentCell.searchImageLeading)
            make.bottom.equalToSuperview().offset(UR.Constants.CurrentCell.searchImageBottom)
            make.height.equalTo(UR.Constants.CurrentCell.searchImageHeight)
            make.width.equalTo(UR.Constants.CurrentCell.searchImageWidth)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(UR.Constants.CurrentCell.locationImageTrailing)
            make.bottom.equalToSuperview().offset(UR.Constants.CurrentCell.locationImageBottom)
            make.height.equalTo(UR.Constants.CurrentCell.locationImageHeight)
            make.width.equalTo(UR.Constants.CurrentCell.locationImageWidth)
        }
    }
    
    //MARK: - Configure cell
    func configureCell(for current: Current, location: Location) {
        currentTempLabel.text = "\(String(Int(current.tempC))) °C"
        currentCityLabel.text = location.name
        conditionLabel.text = current.condition.text
        
        let newUrl = current.condition.icon.replacingOccurrences(of: "64x64", with: "128x128", options: NSString.CompareOptions.literal, range: nil)
        let url = URL(string: "https:\(newUrl)")
        weatherImage.kf.setImage(with: url)
    }
}
