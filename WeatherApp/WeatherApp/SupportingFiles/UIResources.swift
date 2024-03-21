
import Foundation
import UIKit

//MARK: - UI resources
final class UR {
    
    //MARK: - Colors
    struct Colors {
        static let lightGray = UIColor(named: "light-gray")
        static let indigo = UIColor(named: "indigo")
    }
    
    //MARK: - Images
    struct Images {
        static let imageSearch = UIImage(systemName: "magnifyingglass")
        static let imageLocation = UIImage(systemName: "location")
        static let backgroundImage = UIImage(named: "Splash")!
        static let defaultImage = UIImage(systemName: "questionmark.circle.fill")
    }
    
    //MARK: - Constants
    struct Constants {
        struct CollectionView {
            static let currentSectionItemWidth: CGFloat = 1.0
            static let currentSectionItemHeight: CGFloat = 1.0
            static let currentSectionGroupWidth: CGFloat = 1.0
            static let currentSectionGroupHeight: CGFloat = 0.75
            
            static let hourlySectionItemWidth: CGFloat = 1.0
            static let hourlySectionItemHeight: CGFloat = 1.0
            static let hourlySectionGroupWidth: CGFloat = 0.25
            static let hourlySectionGroupHeight: CGFloat = 150
            
            static let dailySectionItemWidth: CGFloat = 1.0
            static let dailySectionItemHeight: CGFloat = 1.0
            static let dailySectionGroupWidth: CGFloat = 1.0
            static let dailySectionGroupHeight: CGFloat = 100
        }
        
        struct CurrentCell {
            static let dateLeading = 16
            static let dateTop = 8
            static let dateHeight = 32
            
            static let cityTop = 48
            static let cityHeight = 32
            
            static let tempLabelTop = 16
            static let tempLabelHeight = 42
            
            static let conditionTop = 16
            static let conditionHeight = 42
            
            static let weatherImageTop = -16
            static let weatherImageHeight = 128
            static let weatherImageWidth = 128
            
            static let searchImageLeading = 8
            static let searchImageHeight = 48
            static let searchImageWidth = 48
            static let searchImageBottom = -8
            
            static let locationImageTrailing = -8
            static let locationImageBottom = -8
            static let locationImageHeight = 48
            static let locationImageWidth = 48
        }
        
        struct HourlyCell {
            static let hourlyAlpha = 0.9
            static let hourlyCornerRadius: CGFloat = 8
            static let hourltBorderWidth: CGFloat = 2
            
            static let hourLabelTop = 4
            static let hourLabelHeight = 42
            
            static let conditionImageHeight = 64
            static let conditionImageWidth = 64
            
            static let degreeLabelHeight = 42
        }
        
        struct DailyCell {
            static let dailyBorderWidth: CGFloat = 1
            static let dailyAlpha: CGFloat = 0.8
            
            static let dayNameLabelLeading = 32
            static let dayNameLabelHeight = 42
            
            static let conditionImageViewTrailing = -8
            static let conditionImageViewHeight = 64
            static let conditionImageViewWidth = 64
            
            static let minTempLabelTrailing = -8
            static let minTempLabelHeight = 42
            
            static let maxTempLabelTrailing = -16
            static let maxTempLabelHeight = 42
        }
    }
    
    //MARK: - Fonts
    struct Fonts {
        static let cityFont = FM.interBlack(40)
        static let conditionFont = FM.interRegular(36)
        static let tempFont = FM.interBlack(52)
        static let dayNameFont = FM.interBlack(28)
        static let tempCellFont = FM.interRegular(23)
        static let dateFont = FM.interRegular(20)
    }
    
    //MARK: - Date Format
    struct DateFormat {
        static let dayName = "EEEE"
        static let time = "hh:mm"
        static let date = "yyyy-MM-dd"
    }
}
