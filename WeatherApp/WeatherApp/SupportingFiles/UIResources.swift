
import Foundation
import UIKit

final class UR {
    
    //MARK: - Colors
    struct Colors {
        static let black = UIColor(named: "black")
        static let superDrakGray = UIColor(named: "super-dark-gray")
        static let darkGray = UIColor(named: "dark-gray")
        static let gray = UIColor(named: "gray")
        static let lightGray = UIColor(named: "light-gray")
        static let superLightGray = UIColor(named: "super-light-gray")
        static let white = UIColor(named: "white")
        static let blue = UIColor(named: "blue")
        static let darkBlue = UIColor(cgColor: CGColor(red: 0, green: 0.48, blue: 1.28, alpha: 1))
        static let green = UIColor(named: "green")
        static let red = UIColor(named: "red")
        static let lightRed = UIColor(named: "light-red")
        static let indigo = UIColor(named: "indigo")
    }
    
    //MARK: - Images
    struct Images {
        static let imageSearch = UIImage(systemName: "magnifyingglass")
        static let imageLocation = UIImage(systemName: "location")
    }
    
    //MARK: - Constraints
    struct Constraints {
        struct CurrentCell {
            
        }
        
        struct HourlyCell {
            
        }
        
        struct DailyCell {
            
        }
        static let currentDateLeading = 16
        static let currentDateTop = 8
        static let currentDateHeight = 32
        
        static let currentCityTop = 48
        static let currentCityHeight = 32
        
        static let searchImageLeading = 8
        static let searchImageHeight = 48
        static let searchImageWidth = 48
        static let searchImageBottom = -8
        
        static let locationImageTrailing = -8
        static let locationImageBottom = -8
        static let locationImageHeight = 48
        static let locationImageWidth = 48
        
        static let weatherContentLeading = 4
        static let weatherContentTrailing = -4
        static let weatherContentTop = 64
        static let weatherContentHeight = 300
    }
    
    //MARK: - Fonts
    struct Fonts {
        static let cityFont = FM.interBlack(40)
        static let conditionFont = FM.interRegular(36)
        static let tempFont = FM.interBlack(52)
        static let dayNameFont = FM.interBlack(28)
        static let tempCellFont = FM.interRegular(23)
    }
    
    //MARK: - Date Format
    struct DateFormat {
        static let dayName = "EEEE"
        static let time = "hh:mm"
    }
}
