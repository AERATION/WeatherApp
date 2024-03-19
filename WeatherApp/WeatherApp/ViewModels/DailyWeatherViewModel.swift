
import Foundation

final class DailyWeatherViewModel: ObservableObject {
    @Published var forecastDays: [Forecastday] = []
}
