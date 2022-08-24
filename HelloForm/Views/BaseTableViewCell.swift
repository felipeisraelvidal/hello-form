import UIKit

public class BaseTableViewCell<T: Row>: UITableViewCell {
    
    private(set) var indexPath: IndexPath?
    private(set) var model: T?
    
    private var isHiddenCell: Bool = true
    
    private(set) lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private(set) lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var topConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?

    // MARK: - Initializers
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        
        contentView.addSubview(contentStackView)
        
        topConstraint = contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor)
        topConstraint?.isActive = true
        
        leadingConstraint = contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        leadingConstraint?.isActive = true
        
        trailingConstraint = contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        trailingConstraint?.isActive = true
        
        bottomConstraint = contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint?.isActive = true
        
    }
    
    // MARK: - Public methods
    
    open func configure(with model: T, atIndexPath indexPath: IndexPath) {
        self.indexPath = indexPath
        self.model = model
        
        if let image = model.image {
            iconImageView.image = image
            iconImageView.tintColor = model._tintColor
            
            NSLayoutConstraint.activate([
                iconImageView.widthAnchor.constraint(equalToConstant: 25)
            ])
            
            contentStackView.insertArrangedSubview(iconImageView, at: 0)
        } else {
            contentStackView.removeArrangedSubview(iconImageView)
            iconImageView.removeFromSuperview()
        }
        
        if let backgroundColor = model._backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        accessoryType = model._accessoryType
        selectionStyle = model._selectionStyle
        
        topConstraint?.constant = model.edgeInsets.top
        leadingConstraint?.constant = model.edgeInsets.left
        trailingConstraint?.constant = -model.edgeInsets.right
        bottomConstraint?.constant = -model.edgeInsets.bottom
        
        if model._isHiddenSeparator {
            separatorInset = UIEdgeInsets(top: 0, left: 2000, bottom: 0, right: 0)
        }
        
        isHiddenCell = model.isHiddenRow
        
        model.$isHiddenRow.bind { [weak self] state in
            if state != self?.isHiddenCell {
                self?.reloadSection()
                self?.isHiddenCell = state
            }
        }
    }
    
    open func loadView() {}
    
    func reloadRow() {
        if let indexPath = indexPath {
            self.tableView?.reloadRows(at: [indexPath], with: model?._reloadRowAnimation ?? .automatic)
        }
    }
    
    func reloadSection() {
        if let indexPath = indexPath {
            tableView?.reloadSections(IndexSet(integer: indexPath.section), with: model?._reloadRowAnimation ?? .automatic)
        }
    }

}
