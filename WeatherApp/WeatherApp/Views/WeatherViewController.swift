import CoreLocation
import UIKit
import SnapKit
import Combine

class WeatherViewController: UIViewController {
    
    private let newWeather: NewWeather = NewWeather()
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    private let cityText: UITextField = {
        let field = UITextField()
        field.placeholder = "City"
        field.text = "Gedhfhd"
        return field
    } ()
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(newWeather)
//        view.addSubview(cityText)
        makeConstraints()
        newWeather.delegate = self
        

    }
    
    private func makeConstraints() {
        newWeather.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

protocol WeatherCollectionViewProtocolDelegate: AnyObject {
    func showAlertController()
}

extension WeatherViewController: WeatherCollectionViewProtocolDelegate {
    func showAlertController() {

        let alertController = UIAlertController(title: "Погода", message: "Введите город:", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Город"
        }
        
        let textField = alertController.textFields![0]
        
        addObserver(textField: textField)
        
        let searchButton = UIAlertAction(title: "Найти", style: .default) {
            _ in            
            self.newWeather.viewModel.onSearchIconTapped()
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
            .assign(to: \.city, on: newWeather.viewModel)
            .store(in: &subscriptions)
    }
        
}

