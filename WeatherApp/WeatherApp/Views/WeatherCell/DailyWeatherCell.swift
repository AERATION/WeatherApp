
import Foundation
import UIKit

class DailyWeatherCell: UICollectionViewCell {
    static let identifier = "matthew"
    
    //MARK: - Properties
    let dayTimePeriodFormatter = DateFormatter()
    
    private var dayNameLabel: UILabel = {
        let label = UILabel()
        label.text = "12356"
        label.font = UR.Fonts.dayNameFont
        return label
    } ()
    
    private var conditionImageView: UIImageView = {
        let image = UIImageView()
    
        return image
    } ()
    
    private var maxTempLabel: UILabel = {
        let label = UILabel()
        label.text = "1235"
        label.font = UR.Fonts.tempCellFont
        return label
    } ()
    
    private var minTempLabel: UILabel = {
        let label = UILabel()
        label.text = "1235"
        label.font = UR.Fonts.tempCellFont
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dayNameLabel)
        contentView.addSubview(conditionImageView)
        contentView.addSubview(maxTempLabel)
        contentView.addSubview(minTempLabel)
        contentView.backgroundColor = .darkGray
        makeCellConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayNameLabel.text = nil
        conditionImageView.image = nil
        maxTempLabel.text = nil
        minTempLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeCellConstraints() {
        dayNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.centerY.equalToSuperview()
            make.height.equalTo(42)
        }
        
        conditionImageView.snp.makeConstraints { make in
            make.trailing.equalTo(minTempLabel.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.height.equalTo(64)
            make.width.equalTo(64)
        }
        
        minTempLabel.snp.makeConstraints { make in
            make.trailing.equalTo(maxTempLabel.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.height.equalTo(42)
        }
        
        maxTempLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(42)
        }
    }
    
    func configureCell(for day: Forecastday) {
        dayTimePeriodFormatter.dateFormat = UR.DateFormat.dayName
        let date = Date(timeIntervalSince1970: Double(day.dateEpoch))
        self.dayNameLabel.text = self.dayTimePeriodFormatter.string(from: date)
        let url = URL(string: "https:\(day.day.condition.icon)")
        conditionImageView.kf.setImage(with: url)
        self.minTempLabel.text = "\(Int(day.day.mintempC)) °C"
        self.maxTempLabel.text = "/ \(Int(day.day.maxtempC)) °C"
    }
}
