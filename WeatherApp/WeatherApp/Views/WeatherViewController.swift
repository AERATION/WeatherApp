
import UIKit
import SnapKit
import Combine

final class WeatherViewController: UIViewController {
    
    //MARK: - Properties
    private let weatherCollectionView: WeatherCollectionView = WeatherCollectionView()
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Initializations
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Private functions
    private func configureUI() {
        view.addSubview(weatherCollectionView)
        makeConstraints()
        weatherCollectionView.delegate = self
    }
    
    private func makeConstraints() {
        weatherCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - WeatherCollectionViewProtocolDelegate
protocol WeatherCollectionViewProtocolDelegate: AnyObject {
    func showAlertController()
}

extension WeatherViewController: WeatherCollectionViewProtocolDelegate {
    func showAlertController() {
        let alertController = UIAlertController(title: "Погода", message: "Введите город:", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Город"
        }
        
        addObserver(textField: alertController.textFields![0])
        
        let searchButton = UIAlertAction(title: "Найти", style: .default) {
            _ in            
            self.weatherCollectionView.viewModel.onSearchIconTapped()
        }
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        alertController.addAction(cancelButton)
        alertController.addAction(searchButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func addObserver(textField: UITextField) {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: textField)
            .compactMap( {($0.object as? UITextField)?.text ?? "" })
            .assign(to: \.city, on: weatherCollectionView.viewModel)
            .store(in: &subscriptions)
    }
}
