import UIKit

class SwitchRowTableViewCell: BaseTableViewCell<SwitchRow> {

    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var swt: UISwitch = {
        let swt = UISwitch()
        swt.addTarget(self, action: #selector(handleSwitchChange(_:)), for: .valueChanged)
        return swt
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, swt])
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    // MARK: - Public methods
    
    override func configure(with model: SwitchRow, atIndexPath indexPath: IndexPath) {
        super.configure(with: model, atIndexPath: indexPath)
        
        titleLabel.font = model._font
        titleLabel.textColor = model._textColor
        
        titleLabel.text = model.title
        
        swt.tintColor = model._tintColor
        
        model.isOn.bind { result in
            self.swt.setOn(result, animated: true)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        contentStackView.addArrangedSubview(stackView)
    }
    
    // MARK: - Private methods
    
    @objc private func handleSwitchChange(_ sender: UISwitch) {
        model?.isOn.value = sender.isOn
    }

}
