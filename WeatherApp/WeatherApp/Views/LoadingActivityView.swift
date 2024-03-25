
import UIKit

class LoadingIndicatorView: UIView {
    
    private let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let errorLabel: UILabel = UILabel()
    
    //MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupActivityIndicator()
        setupErrorLabel()
        makeConstrains()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func startIndicatorAnimation() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    func stopIndicatorAnimation() {
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
    }
    
    //MARK: - Private methods
    private func setupActivityIndicator() {
        self.addSubview(loadingIndicator)
        loadingIndicator.color = .black
        loadingIndicator.style = .large
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = true
    }
    
    private func setupErrorLabel() {
        self.addSubview(errorLabel)
        errorLabel.text = UR.Constants.CollectionView.indicatorText
        errorLabel.font = UR.Fonts.tempCellFont
    }
    
    private func makeConstrains() {
        loadingIndicator.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(loadingIndicator.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
}
