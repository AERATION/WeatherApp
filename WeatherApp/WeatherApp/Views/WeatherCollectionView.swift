
import UIKit
import Combine

final class WeatherCollectionView: UIView {
    
    //MARK: - Properties
    weak var delegate: WeatherCollectionViewProtocolDelegate?
    
    var viewModel: WeatherViewModel = WeatherViewModel()
    
    private lazy var collectionView: UICollectionView = UICollectionView()
    
    private lazy var activityIndicatorView: LoadingIndicatorView = LoadingIndicatorView()
    
    private var subscriptions = Set<AnyCancellable>()

    //MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
        setupLoadingIndicator()
        bindToViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Private functions
    private func bindToViewModel() {
        viewModel.$weather
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
            .store(in: &subscriptions)
        viewModel.$loadingState
            .sink { [weak self] state in
                switch state {
                    case .loading:
                        self?.activityIndicatorView.startIndicatorAnimation()
                        self?.activityIndicatorView.errorLabel.isHidden = true
                    case .failed:
                        self?.activityIndicatorView.stopIndicatorAnimation()
                        self?.activityIndicatorView.errorLabel.isHidden = false
                    case .success:
                        self?.activityIndicatorView.stopIndicatorAnimation()
                        self?.activityIndicatorView.errorLabel.isHidden = true
                    case .none:
                        self?.activityIndicatorView.stopIndicatorAnimation()
                        self?.activityIndicatorView.errorLabel.isHidden = true
                }
            }
            .store(in: &subscriptions)
    }
    
    private func setupLoadingIndicator() {
        self.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(UR.Constants.CollectionView.activityIndicatorTop)
            make.height.equalTo(UR.Constants.CollectionView.activityIndicatorHeight)
        }
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
        let section = CollectionViewSection.allCases[sectionIndex]
        
        switch section {
            case .current:
                let item = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(UR.Constants.CollectionView.currentSectionItemWidth),
                    heightDimension: .fractionalHeight(UR.Constants.CollectionView.currentSectionItemHeight)
                ))

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: .fractionalWidth(UR.Constants.CollectionView.currentSectionGroupWidth), heightDimension: .fractionalWidth(UR.Constants.CollectionView.currentSectionGroupHeight)),
                    subitems: [item]
                )
            
                return NSCollectionLayoutSection(group: group)
            case .hourly:
                let item = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(UR.Constants.CollectionView.hourlySectionItemWidth),
                    heightDimension: .fractionalHeight(UR.Constants.CollectionView.hourlySectionItemHeight)
                ))

                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(UR.Constants.CollectionView.hourlySectionGroupWidth),
                                      heightDimension: .absolute(UR.Constants.CollectionView.hourlySectionGroupHeight)),
                    subitems: [item]
                )
                group.contentInsets = .init(top: UR.Constants.CollectionView.hourlySectionInsestTop, leading: UR.Constants.CollectionView.hourlySectionInsestLeading, bottom: UR.Constants.CollectionView.hourlySectionInsestBottom, trailing: UR.Constants.CollectionView.hourlySectionInsestTrailing)
            
                let section =  NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            
                return section
            case .daily:
                let item = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(UR.Constants.CollectionView.dailySectionItemWidth),
                    heightDimension: .fractionalHeight(UR.Constants.CollectionView.dailySectionItemHeight)
                ))

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: .fractionalWidth(UR.Constants.CollectionView.dailySectionGroupWidth),
                                      heightDimension: .absolute(UR.Constants.CollectionView.dailySectionGroupHeight)),
                    subitems: [item]
                )

                return NSCollectionLayoutSection(group: group)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension WeatherCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CollectionViewSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionViewSection = CollectionViewSection.allCases[section]
        
        switch collectionViewSection {
            case .current:
                return 1
            case .hourly:
                if let hourlyCount = viewModel.weather?.forecast.forecastday.first!.hour.count {
                    return hourlyCount
                } else {
                    return 24
                }
            case .daily:
                if let dailyCount = viewModel.weather?.forecast.forecastday.count {
                    return dailyCount
                } else {
                    return 7
                }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewSection = CollectionViewSection.allCases[indexPath.section]
        switch collectionViewSection {
            case .current:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCell.identifier, for: indexPath) as? CurrentWeatherCell else {
                    return UICollectionViewCell()
                }
            
                cell.searchIconTapedAction = {
                    self.delegate?.showAlertController()
                }
                cell.locationIconTapedAction = {
                    self.viewModel.getCurrentWeather()
                }
            
                if let currentCell = viewModel.weather?.current {
                    if let currentLocation = viewModel.weather?.location {
                        cell.configureCell(for: currentCell, location: currentLocation)
                    }
                }
                return cell
            case .hourly:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.identifier, for: indexPath) as? HourlyWeatherCell else {
                    return UICollectionViewCell()
                }
            
                if let collectionHours = viewModel.weather?.forecast.forecastday.first?.hour {
                    cell.configureCell(for: collectionHours[indexPath.row])
                }
            
                return cell
            case .daily:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCell.identifier, for: indexPath) as? DailyWeatherCell else {
                    return UICollectionViewCell()
                }
            
                if let collectionDays = viewModel.weather?.forecast.forecastday {
                    cell.configureCell(for: collectionDays[indexPath.row])
                }
            
                return cell
        }
    }
}
