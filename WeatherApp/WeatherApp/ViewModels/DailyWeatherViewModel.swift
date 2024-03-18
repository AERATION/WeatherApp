

import Foundation

class DailyWeatherViewModel: ObservableObject {
    @Published var forecastDays: [Forecastday] = []
}
