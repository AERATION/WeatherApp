
import UIKit
import Foundation
import Combine

class WeatherView: UIView {
    
    private var collectionView: UICollectionView = UICollectionView()
    
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: WeatherViewModel = WeatherViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        createCollectionView()
        connectViewModel()
    }
    
    init() {
        super.init(frame: .zero)
        createCollectionView()
        connectViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func connectViewModel() {
        viewModel.getCurrentWeather()
        
        viewModel.collectionDailyVM.$forecastDays
            .sink { [weak self] forecast in
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
        
        viewModel.collectionHourlyVM.$hours
            .sink { [weak self] hourly in
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    private func createCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.layout(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.register(HourlyWeatherCell.self,
                                forCellWithReuseIdentifier: HourlyWeatherCell.identifier)
        collectionView.register(DailyWeatherCell.self,
                                forCellWithReuseIdentifier: DailyWeatherCell.identifier)
        addSubview(collectionView)
        
//        collectionView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        self.collectionView = collectionView
    }
    
    func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 100, height: 100)
        return layout
    }
    
    private func layout(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section = CurrentWeatherSection.allCases[sectionIndex]
        
        switch section {
            case .hourly:
                let item = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                ))


                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(0.25),
                                      heightDimension: .absolute(150)),
                    subitems: [item]
                )
                group.contentInsets = .init(top: 1, leading: 2, bottom: 1, trailing: 2)

                let section =  NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
            case .daily:
                let item = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                ))

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                      heightDimension: .absolute(100)),
                    subitems: [item]
                )
                group.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)

                return NSCollectionLayoutSection(group: group)
        }
    }
}

extension WeatherView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sect = CurrentWeatherSection.allCases[section]
        switch sect {
            case .daily:
                return (viewModel.weather?.forecast.forecastday.count)!
            case .hourly:
                return (viewModel.weather?.forecast.forecastday.first?.hour.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.identifier, for: indexPath) as! HourlyWeatherCell
                let hour = viewModel.collectionHourlyVM.hours[indexPath.row]
                cell.configureCell(for: hour)
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCell.identifier, for: indexPath) as! DailyWeatherCell
                let day = viewModel.collectionDailyVM.forecastDays[indexPath.row]
                cell.configureCell(for: day)
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCell.identifier, for: indexPath) as! DailyWeatherCell
                let day = viewModel.collectionDailyVM.forecastDays[indexPath.row]
                cell.configureCell(for: day)
                return cell
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 180)
    }
}

