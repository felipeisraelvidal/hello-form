import UIKit

class SliderRowTableViewCell: BaseTableViewCell<SliderRow> {
    
    // MARK: - Views
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        return slider
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [slider])
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    private(set) var minimumValueLabel: UILabel?
    private(set) var maximumValueLabel: UILabel?
    
    // MARK: - Public methods
    
    override func configure(with model: SliderRow, atIndexPath indexPath: IndexPath) {
        super.configure(with: model, atIndexPath: indexPath)
        
        slider.minimumValue = model.bounds.lowerBound
        slider.maximumValue = model.bounds.upperBound
        slider.value = model.value
        
        self.minimumValueLabel = model.minimumValueLabel
        self.maximumValueLabel = model.maximumValueLabel
        
        if let minimumValueLabel = minimumValueLabel {
            stackView.insertArrangedSubview(minimumValueLabel, at: 0)
        }
        
        if let maximumValueLabel = maximumValueLabel {
            stackView.addArrangedSubview(maximumValueLabel)
        }
        
        model.$value.bind { [weak self] result in
            self?.slider.setValue(result, animated: true)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        contentStackView.addArrangedSubview(stackView)
    }
    
    // MARK: - Private methods
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        if let step = model?.step, step > 1 {
            let roundedValue = round(sender.value / step) * step
            sender.value = roundedValue
        }
        model?.changeValue(to: sender.value)
    }
    
}
