import UIKit

public class TextRowTableViewCell: BaseTableViewCell<TextRow> {
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // MARK: - Public methods
    
    public override func configure(with model: TextRow, atIndexPath indexPath: IndexPath) {
        super.configure(with: model, atIndexPath: indexPath)
        
        titleLabel.font = model._font
        titleLabel.textColor = model._textColor
        titleLabel.textAlignment = model._textAlignment
        
        switch model.text {
        case .left(let value):
            titleLabel.text = value
        case .right(let value):
            value.bind { [weak self] result in
                self?.titleLabel.text = result
                self?.reloadRow()
            }
        }
    }
    
    public override func loadView() {
        super.loadView()
        contentStackView.addArrangedSubview(titleLabel)
    }

}
