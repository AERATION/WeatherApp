
import UIKit

final class HourlyWeatherCell: UICollectionViewCell {
    
    //MARK: - Identifier
    static let identifier = UR.Constants.HourlyCell.hourlyIdentifier
    
    //MARK: - Properties
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.font = UR.Fonts.tempCellFont
        return label
    } ()
    
    private let conditionImageView: UIImageView = {
        let image = UIImageView()
        image.image = UR.Images.defaultImage
        return image
    } ()
    
    private let degreeLabel: UILabel = {
        let label = UILabel()
        label.font = UR.Fonts.tempCellFont
        return label
    } ()

    //MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hourLabel.text = nil
        conditionImageView.image = nil
        degreeLabel.text = nil
    }
    
    //MARK: - Private functions
    private func configureCellUI() {
        contentView.addSubview(hourLabel)
        contentView.addSubview(conditionImageView)
        contentView.addSubview(degreeLabel)
        contentView.backgroundColor = UR.Colors.indigo
        contentView.layer.borderColor = UR.Colors.lightGray?.cgColor
        contentView.alpha = UR.Constants.HourlyCell.hourlyAlpha
        contentView.layer.cornerRadius = UR.Constants.HourlyCell.hourlyCornerRadius
        contentView.layer.borderWidth = UR.Constants.HourlyCell.hourltBorderWidth
        makeCellConstraints()
    }

    private func makeCellConstraints() {
        hourLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UR.Constants.HourlyCell.hourLabelTop)
            make.centerX.equalToSuperview()
            make.height.equalTo(UR.Constants.HourlyCell.hourLabelHeight)
        }
        
        conditionImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(UR.Constants.HourlyCell.conditionImageWidth)
            make.height.equalTo(UR.Constants.HourlyCell.conditionImageHeight)
        }
        
        degreeLabel.snp.makeConstraints { make in
            make.top.equalTo(conditionImageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(UR.Constants.HourlyCell.degreeLabelHeight)
        }
    }
    
    //MARK: - Configure cell
    func configureCell(for hour: Hour) {
        degreeLabel.text = "\(String(Int(hour.tempC))) °C"
        
        let date = Date(timeIntervalSince1970: Double(hour.timeEpoch))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let newTime = formatter.string(from: date)
        hourLabel.text = newTime
        
        let url = URL(string: "https:\(hour.condition.icon)")
        conditionImageView.kf.setImage(with: url)
    }
}
