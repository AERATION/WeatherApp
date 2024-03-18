
import Foundation
import UIKit

class HourlyWeatherCell: UICollectionViewCell {
    static let identifier = "hey"
    
    //MARK: - Properties
    let dayTimePeriodFormatter = DateFormatter()

    
    private var hourLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    } ()
    
    private let conditionImageView: UIImageView = {
        let image = UIImageView()
        return image
    } ()
    
    private let degreeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    } ()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(hourLabel)
        contentView.addSubview(conditionImageView)
        contentView.addSubview(degreeLabel)
        contentView.backgroundColor = .cyan
        makeCellConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hourLabel.text = nil
        conditionImageView.image = nil
        degreeLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeCellConstraints() {
        hourLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(42)
        }
        
        conditionImageView.snp.makeConstraints { make in
            make.top.equalTo(hourLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(64)
            make.height.equalTo(64)
        }
        
        degreeLabel.snp.makeConstraints { make in
            make.top.equalTo(conditionImageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(42)
        }
    }
    
    func configureCell(for hour: Hour) {
        dayTimePeriodFormatter.dateFormat = UR.DateFormat.time
       
        let date = Date(timeIntervalSince1970: Double(hour.timeEpoch))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let newTime = formatter.string(from: date)
        self.hourLabel.text = newTime
        let url = URL(string: "https:\(hour.condition.icon)")
        conditionImageView.kf.setImage(with: url)
        degreeLabel.text = "\(String(Int(hour.tempC))) °C"
    }
}
