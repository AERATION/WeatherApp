
import Foundation
import UIKit

class UR {
    
    struct Images {
        static let imageSearch = UIImage(systemName: "magnifyingglass")
        static let imageLocation = UIImage(systemName: "location")
    }
    
    struct Constraints {
        static let currentDateLeading = 16
        static let currentDateTop = 8
        static let currentDateHeight = 32
        
        static let currentCityTop = 32
        static let currentCityHeight = 32
        
        static let searchImageLeading = 8
        static let searchImageHeight = 32
        static let searchImageWidth = 32
        static let searchImageBottom = -8
        
        static let locationImageTrailing = -8
        static let locationImageBottom = -8
        static let locationImageHeight = 32
        static let locationImageWidth = 32
        
        static let weatherContentLeading = 4
        static let weatherContentTrailing = -4
        static let weatherContentTop = 64
        static let weatherContentHeight = 300
    }
    
    struct Fonts {
        static let cityFont = FM.interBlack(40)
        static let conditionFont = FM.interRegular(36)
        static let tempFont = FM.interBlack(52)
        static let dayNameFont = FM.interBlack(28)
        static let tempCellFont = FM.interRegular(20)
    }
    
    //MARK: - Date Format
    struct DateFormat {
        static let dayName = "EEEE"
        static let time = "hh:mm"
    }
}
