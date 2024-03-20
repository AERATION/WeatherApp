
import UIKit
import Foundation
import Combine

final class WeatherCollectionView: UIView {
    
    //MARK: - Properties
    private var collectionView: UICollectionView!
    
    private var subscriptions = Set<AnyCancellable>()
    
    weak var delegate: WeatherCollectionViewProtocolDelegate?
    
    var viewModel: WeatherViewModel = WeatherViewModel()
    
    //MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
        connectViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Private functions
    private func connectViewModel() {
        viewModel.$collectionDaily
            .sink { [weak self] forecast in
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
        
        viewModel.$collectionHourly
            .sink { [weak self] hourly in
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.layout(for: sectionIndex)
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.backgroundColor = UIColor(patternImage: UR.Images.backgroundImage)
        collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.identifier)
        collectionView.register(DailyWeatherCell.self, forCellWithReuseIdentifier: DailyWeatherCell.identifier)
        collectionView.register(CurrentWeatherCell.self, forCellWithReuseIdentifier: CurrentWeatherCell.identifier)
        collectionView.dataSource = self
    }
    
    private func layout(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch sectionIndex {
            case 0:
                let item = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(UR.Constraints.CollectionView.currentSectionItemWidth),
                    heightDimension: .fractionalHeight(UR.Constraints.CollectionView.currentSectionItemHeight)
                ))

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: .fractionalWidth(UR.Constraints.CollectionView.currentSectionGroupWidth), heightDimension: .fractionalWidth(UR.Constraints.CollectionView.currentSectionGroupHeight)),
                    subitems: [item]
                )
            
                return NSCollectionLayoutSection(group: group)
            case 1:
                let item = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(UR.Constraints.CollectionView.hourlySectionItemWidth),
                    heightDimension: .fractionalHeight(UR.Constraints.CollectionView.hourlySectionItemHeight)
                ))

                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(UR.Constraints.CollectionView.hourlySectionGroupWidth),
                                      heightDimension: .absolute(UR.Constraints.CollectionView.hourlySectionGroupHeight)),
                    subitems: [item]
                )
                group.contentInsets = .init(top: 1, leading: 2, bottom: 1, trailing: 2)
            
                let section =  NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            
                return section
            case 2:
                let item = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(UR.Constraints.CollectionView.dailySectionItemWidth),
                    heightDimension: .fractionalHeight(UR.Constraints.CollectionView.dailySectionItemHeight)
                ))

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: .fractionalWidth(UR.Constraints.CollectionView.dailySectionGroupWidth),
                                      heightDimension: .absolute(UR.Constraints.CollectionView.dailySectionGroupHeight)),
                    subitems: [item]
                )

                return NSCollectionLayoutSection(group: group)
            default:
                let item = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(UR.Constraints.CollectionView.dailySectionItemWidth),
                    heightDimension: .fractionalHeight(UR.Constraints.CollectionView.dailySectionItemHeight)
                ))

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: .fractionalWidth(UR.Constraints.CollectionView.dailySectionGroupWidth),
                                      heightDimension: .absolute(UR.Constraints.CollectionView.dailySectionGroupHeight)),
                    subitems: [item]
                )

                return NSCollectionLayoutSection(group: group)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension WeatherCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 1
            case 1:
                return viewModel.collectionHourly.count
            case 2:
                return viewModel.collectionDaily.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCell.identifier, for: indexPath) as? CurrentWeatherCell else {
                    return UICollectionViewCell()
                }
                cell.searchIconTapedAction = {
                    self.delegate?.showAlertController()
                }
                cell.locationIconTapedAction = {
                    self.viewModel.getCurrentWeather()
                }
                cell.configureCell(for: viewModel.current, location: viewModel.location)
                return cell
            case 1:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.identifier, for: indexPath) as? HourlyWeatherCell else {
                    return UICollectionViewCell()
                }
                let hour = viewModel.collectionHourly[indexPath.row]
                cell.configureCell(for: hour)
                return cell
            case 2:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCell.identifier, for: indexPath) as? DailyWeatherCell else {
                    return UICollectionViewCell()
                }
                let day = viewModel.collectionDaily[indexPath.row]
                cell.configureCell(for: day)
                return cell
            default:
                return UICollectionViewCell()
        }
        
    }
    
    
}
