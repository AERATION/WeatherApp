
import UIKit
import Foundation
import Combine

final class NewWeather: UIView {
    
    private var newCollectionView: UICollectionView!
    
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: WeatherViewModel = WeatherViewModel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false

        setupCollectionView()
        connectViewModel()
    }
    
    init() {
        super.init(frame: .zero)
        setupCollectionView()
        connectViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func connectViewModel() {
//        viewModel.getCurrentWeather()
        
        viewModel.collectionDailyVM.$forecastDays
            .sink { [weak self] forecast in
                self?.newCollectionView.reloadData()
            }
            .store(in: &subscriptions)
        
        viewModel.collectionHourlyVM.$hours
            .sink { [weak self] hourly in
                self?.newCollectionView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.layout(for: sectionIndex)
        }
        newCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(newCollectionView)
        newCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        newCollectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.identifier)
        newCollectionView.register(DailyWeatherCell.self, forCellWithReuseIdentifier: DailyWeatherCell.identifier)
        newCollectionView.register(CurrentWeatherCell.self, forCellWithReuseIdentifier: CurrentWeatherCell.identifier)
        newCollectionView.dataSource = self
    }
    
    private func layout(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch sectionIndex {
            case 0:
                let item = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                ))

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.75)),
                    subitems: [item]
                )

                return NSCollectionLayoutSection(group: group)
            case 1:
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
            case 2:
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
            default:
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
        }
    }
}

extension NewWeather: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 1
            case 1:
                return viewModel.collectionHourlyVM.hours.count
            case 2:
                return viewModel.collectionDailyVM.forecastDays.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
                guard let cell = newCollectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCell.identifier, for: indexPath) as? CurrentWeatherCell else {
                    return UICollectionViewCell()
                }
                cell.configureCell(for: viewModel.current, location: viewModel.location)
                return cell
            case 1:
                guard let cell = newCollectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.identifier, for: indexPath) as? HourlyWeatherCell else {
                    return UICollectionViewCell()
                }
                let hour = viewModel.collectionHourlyVM.hours[indexPath.row]
                cell.configureCell(for: hour)
                return cell
            case 2:
                guard let cell = newCollectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCell.identifier, for: indexPath) as? DailyWeatherCell else {
                    return UICollectionViewCell()
                }
                let day = viewModel.collectionDailyVM.forecastDays[indexPath.row]
                cell.configureCell(for: day)
                return cell
            default:
                return UICollectionViewCell()
        }
        
    }
    
    
}
