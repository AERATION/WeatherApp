
import UIKit

final class DailyWeatherCell: UICollectionViewCell {
    
    //MARK: - Identifier
    static let identifier = "DailyWeatherCell"
    
    //MARK: - Properties
    private let dayTimePeriodFormatter = DateFormatter()
    
    private var dayNameLabel: UILabel = {
        let label = UILabel()
        label.font = UR.Fonts.dayNameFont
        return label
    } ()
    
    private var conditionImageView: UIImageView = {
        let image = UIImageView()
        return image
    } ()
    
    private var maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = UR.Fonts.tempCellFont
        return label
    } ()
    
    private var minTempLabel: UILabel = {
        let label = UILabel()
        label.font = UR.Fonts.tempCellFont
        return label
    } ()
    
    //MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dayNameLabel)
        contentView.addSubview(conditionImageView)
        contentView.addSubview(maxTempLabel)
        contentView.addSubview(minTempLabel)
        contentView.backgroundColor = UR.Colors.indigo
        contentView.layer.borderWidth = UR.Constants.DailyCell.dailyBorderWidth
        contentView.layer.borderColor = UR.Colors.lightGray?.cgColor
        contentView.alpha = UR.Constants.DailyCell.dailyAlpha
        makeCellConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayNameLabel.text = nil
        conditionImageView.image = nil
        maxTempLabel.text = nil
        minTempLabel.text = nil
    }
    
    //MARK: - Private functions
    private func makeCellConstraints() {
        dayNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UR.Constants.DailyCell.dayNameLabelLeading)
            make.centerY.equalToSuperview()
            make.height.equalTo(UR.Constants.DailyCell.dayNameLabelHeight)
        }
        
        conditionImageView.snp.makeConstraints { make in
            make.trailing.equalTo(minTempLabel.snp.leading).offset(UR.Constants.DailyCell.conditionImageViewTrailing)
            make.centerY.equalToSuperview()
            make.height.equalTo(UR.Constants.DailyCell.conditionImageViewHeight)
            make.width.equalTo(UR.Constants.DailyCell.conditionImageViewWidth)
        }
        
        minTempLabel.snp.makeConstraints { make in
            make.trailing.equalTo(maxTempLabel.snp.leading).offset(UR.Constants.DailyCell.minTempLabelTrailing)
            make.centerY.equalToSuperview()
            make.height.equalTo(UR.Constants.DailyCell.minTempLabelHeight)
        }
        
        maxTempLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(UR.Constants.DailyCell.maxTempLabelTrailing)
            make.centerY.equalToSuperview()
            make.height.equalTo(UR.Constants.DailyCell.maxTempLabelHeight)
        }
    }
    
    //MARK: - Configure cell
    func configureCell(for day: Forecastday) {
        dayTimePeriodFormatter.dateFormat = UR.DateFormat.dayName
        let date = Date(timeIntervalSince1970: Double(day.dateEpoch))
        dayNameLabel.text = self.dayTimePeriodFormatter.string(from: date)
        
        let url = URL(string: "https:\(day.day.condition.icon)")
        conditionImageView.kf.setImage(with: url)
        
        minTempLabel.text = "\(Int(day.day.mintempC)) °C"
        maxTempLabel.text = "/ \(Int(day.day.maxtempC)) °C"
    }
}
