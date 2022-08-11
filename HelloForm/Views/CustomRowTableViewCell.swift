import UIKit

class CustomRowTableViewCell: BaseTableViewCell<CustomRow> {
    
    override func configure(with model: CustomRow, atIndexPath indexPath: IndexPath) {
        super.configure(with: model, atIndexPath: indexPath)
        
        contentStackView.addArrangedSubview(model.content)
    }
    
    override func loadView() {
        super.loadView()
    }

}
