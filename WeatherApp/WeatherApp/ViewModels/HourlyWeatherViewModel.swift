
import Foundation

final class HourlyWeatherViewModel: ObservableObject {
    @Published var hours: [Hour] = []
}
