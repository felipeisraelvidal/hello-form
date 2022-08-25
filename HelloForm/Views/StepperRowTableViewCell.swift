import UIKit

class StepperRowTableViewCell: BaseTableViewCell<StepperRow> {
    
    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        return stepper
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, stepper])
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    // MARK: - Public methods
    
    override func configure(with model: StepperRow, atIndexPath indexPath: IndexPath) {
        super.configure(with: model, atIndexPath: indexPath)
        
        titleLabel.font = model._font
        titleLabel.textColor = model._textColor
        
        titleLabel.text = model.title
        
        stepper.minimumValue = model.bounds.lowerBound
        stepper.maximumValue = model.bounds.upperBound
        stepper.stepValue = model.step
        stepper.value = model.value
        
        model.$value.bind { [weak self] result in
            self?.stepper.value = result
        }
    }
    
    override func loadView() {
        super.loadView()
        
        contentStackView.addArrangedSubview(stackView)
    }
    
    // MARK: - Private methods
    
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        if let oldValue = model?.value {
            if sender.value > oldValue {
                model?.onIncrement?()
            } else if sender.value < oldValue {
                model?.onDecrement?()
            }
        }
        model?.changeValue(to: sender.value)
    }
    
}
