import UIKit

open class FormViewController: UIViewController {
    
    // MARK: - Proprties
    
    private(set) var sections: [FormSection] = []
    
    open var tableViewStyle: UITableView.Style {
        return .grouped
    }
    
    // MARK: - Views
    
    private(set) public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: tableViewStyle)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    open override func loadView() {
        super.loadView()
        
        setupConstraints()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        for selectedIndexPath in tableView.indexPathsForSelectedRows ?? [] {
            let section = sections[selectedIndexPath.section]
            if !section._preventDeselectionWhenViewAppear {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func registerCells() {
        
        tableView.register(TextRowTableViewCell.self, forCellReuseIdentifier: TextRowTableViewCell.identifier)
        tableView.register(CustomRowTableViewCell.self, forCellReuseIdentifier: CustomRowTableViewCell.identifier)
        tableView.register(DefaultTitleDescriptionRowTableViewCell.self, forCellReuseIdentifier: DefaultTitleDescriptionRowTableViewCell.identifier)
        tableView.register(SubtitleTitleDescriptionRowTableViewCell.self, forCellReuseIdentifier: SubtitleTitleDescriptionRowTableViewCell.identifier)
        tableView.register(TextFieldRowTableViewCell.self, forCellReuseIdentifier: TextFieldRowTableViewCell.identifier)
        tableView.register(SwitchRowTableViewCell.self, forCellReuseIdentifier: SwitchRowTableViewCell.identifier)
        tableView.register(StepperRowTableViewCell.self, forCellReuseIdentifier: StepperRowTableViewCell.identifier)
        tableView.register(SliderRowTableViewCell.self, forCellReuseIdentifier: SliderRowTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    private func handleCellSelection(row: Row, at indexPath: IndexPath) {
        if row._deselectWhenSelect {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        row.action?()
    }
    
    private func handleAccessoryButtonTap(row: Row, at indexPath: IndexPath) {
        row.detailDisclosureButtonAction?()
    }
    
    // MARK: - Public methods
    
    public func makeSections(@FormBuilder _ content: () -> [FormSection]) {
        self.sections = content()
        tableView.reloadData()
    }
    
    public func insertSection(_ section: FormSection, at index: Int) {
        self.sections.insert(section, at: index)
        
        tableView.beginUpdates()
        tableView.insertSections(IndexSet(integer: index), with: .automatic)
        tableView.endUpdates()
    }
    
    public func appendSection(_ section: FormSection) {
        let sectionIndex = sections.count
        
        self.sections.append(section)
        
        tableView.beginUpdates()
        tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        tableView.endUpdates()
    }
    
    public func insertRow(_ row: FormRowBase, atSection sectionIdentifier: String, at index: Int) {
        if let setionIndex = sections.firstIndex(where: { $0.identifier == sectionIdentifier }) {
            self.sections[setionIndex].insert(row, at: index)
            
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: index, section: setionIndex)], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    public func appendRow(_ row: FormRowBase, atSection sectionIdentifier: String) {
        if let sectionIndex = sections.firstIndex(where: { $0.identifier == sectionIdentifier }) {
            let rowIndex = sections[sectionIndex].rows.count
            
            self.sections[sectionIndex].insert(row, at: rowIndex)
            
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: rowIndex, section: sectionIndex)], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    public func reloadData(animated flag: Bool) {
        if flag {
            let sections = IndexSet(integersIn: 0..<tableView.numberOfSections)
            tableView.reloadSections(sections, with: .automatic)
        }
    }
    
}

extension FormViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footer
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        
        switch row.self {
        case let formRow where formRow is TextRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextRowTableViewCell.identifier, for: indexPath) as? TextRowTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: formRow as! TextRow, atIndexPath: indexPath)
            
            return cell
        case let formRow where formRow is TitleDescriptionRow:
            let formRow = formRow as! TitleDescriptionRow
            switch formRow.cellStyle {
            case .default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTitleDescriptionRowTableViewCell.identifier, for: indexPath) as? DefaultTitleDescriptionRowTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.configure(with: formRow, atIndexPath: indexPath)
                
                return cell
            case .subtitle:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SubtitleTitleDescriptionRowTableViewCell.identifier, for: indexPath) as? SubtitleTitleDescriptionRowTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.configure(with: formRow, atIndexPath: indexPath)
                
                return cell
            }
        case let formRow where formRow is CustomRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomRowTableViewCell.identifier, for: indexPath) as? CustomRowTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: formRow as! CustomRow, atIndexPath: indexPath)
            
            return cell
        case let formRow where formRow is TextFieldRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldRowTableViewCell.identifier, for: indexPath) as? TextFieldRowTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: formRow as! TextFieldRow, atIndexPath: indexPath)
            
            return cell
        case let formRow where formRow is SwitchRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchRowTableViewCell.identifier, for: indexPath) as? SwitchRowTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: formRow as! SwitchRow, atIndexPath: indexPath)
            
            return cell
        case let formRow where formRow is StepperRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StepperRowTableViewCell.identifier, for: indexPath) as? StepperRowTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: formRow as! StepperRow, atIndexPath: indexPath)
            
            return cell
        case let formRow where formRow is SliderRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SliderRowTableViewCell.identifier, for: indexPath) as? SliderRowTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: formRow as! SliderRow, atIndexPath: indexPath)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.textLabel?.text = "Row \(indexPath.row)"
            
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        
        switch row.self {
        case let formRow where formRow is TextRow:
            handleCellSelection(row: (formRow as! TextRow), at: indexPath)
        case let formRow where formRow is TitleDescriptionRow:
            handleCellSelection(row: (formRow as! TitleDescriptionRow), at: indexPath)
        case let formRow where formRow is CustomRow:
            handleCellSelection(row: (formRow as! CustomRow), at: indexPath)
        case let formRow where formRow is TextFieldRow:
            handleCellSelection(row: (formRow as! TextFieldRow), at: indexPath)
        case let formRow where formRow is SwitchRow:
            handleCellSelection(row: (formRow as! SwitchRow), at: indexPath)
        case let formRow where formRow is StepperRow:
            handleCellSelection(row: (formRow as! StepperRow), at: indexPath)
        case let formRow where formRow is SliderRow:
            handleCellSelection(row: (formRow as! SliderRow), at: indexPath)
        default:
            break
        }
    }
    
    public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row.self {
        case let formRow where formRow is TextRow:
            handleAccessoryButtonTap(row: (formRow as! TextRow), at: indexPath)
        case let formRow where formRow is TitleDescriptionRow:
            handleAccessoryButtonTap(row: (formRow as! TitleDescriptionRow), at: indexPath)
        case let formRow where formRow is CustomRow:
            handleAccessoryButtonTap(row: (formRow as! CustomRow), at: indexPath)
        case let formRow where formRow is TextFieldRow:
            handleAccessoryButtonTap(row: (formRow as! TextFieldRow), at: indexPath)
        case let formRow where formRow is SwitchRow:
            handleAccessoryButtonTap(row: (formRow as! SwitchRow), at: indexPath)
        case let formRow where formRow is SliderRow:
            handleAccessoryButtonTap(row: (formRow as! SliderRow), at: indexPath)
        default:
            break
        }
    }
    
}
