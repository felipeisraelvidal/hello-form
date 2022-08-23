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
    
    private func dequeueReusableCell<T: Row, R: BaseTableViewCell<T>>(rowType: T.Type, cellType: R.Type, formRow: T, atIndexPath indexPath: IndexPath) -> R? {
        if formRow._isHiddenRow.value == true {
            return nil
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.identifier, for: indexPath) as? R else {
            return nil
        }
        
        cell.configure(with: formRow, atIndexPath: indexPath)
        
        return cell
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
        return sections[section].rows.filter({ ($0 as? FormRow)?._isHiddenRow.value == false }).count
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = sections[indexPath.section].rows.filter({ ($0 as? FormRow)?._isHiddenRow.value == false })[indexPath.row] as? FormRow else { return UITableViewCell() }
        
        switch row.self {
        case let formRow where formRow is TextRow:
            guard let cell = dequeueReusableCell(rowType: TextRow.self, cellType: TextRowTableViewCell.self, formRow: formRow as! TextRow, atIndexPath: indexPath) else {
                return UITableViewCell()
            }
            return cell
        case let formRow where formRow is TitleDescriptionRow:
            let formRow = formRow as! TitleDescriptionRow
            switch formRow.cellStyle {
            case .default:
                guard let cell = dequeueReusableCell(rowType: TitleDescriptionRow.self, cellType: DefaultTitleDescriptionRowTableViewCell.self, formRow: formRow, atIndexPath: indexPath) else {
                    return UITableViewCell()
                }
                return cell
            case .subtitle:
                guard let cell = dequeueReusableCell(rowType: TitleDescriptionRow.self, cellType: SubtitleTitleDescriptionRowTableViewCell.self, formRow: formRow, atIndexPath: indexPath) else {
                    return UITableViewCell()
                }
                return cell
            }
        case let formRow where formRow is CustomRow:
            guard let cell = dequeueReusableCell(rowType: CustomRow.self, cellType: CustomRowTableViewCell.self, formRow: formRow as! CustomRow, atIndexPath: indexPath) else {
                return UITableViewCell()
            }
            return cell
        case let formRow where formRow is TextFieldRow:
            guard let cell = dequeueReusableCell(rowType: TextFieldRow.self, cellType: TextFieldRowTableViewCell.self, formRow: formRow as! TextFieldRow, atIndexPath: indexPath) else {
                return UITableViewCell()
            }
            return cell
        case let formRow where formRow is SwitchRow:
            guard let cell = dequeueReusableCell(rowType: SwitchRow.self, cellType: SwitchRowTableViewCell.self, formRow: formRow as! SwitchRow, atIndexPath: indexPath) else {
                return UITableViewCell()
            }
            return cell
        case let formRow where formRow is StepperRow:
            guard let cell = dequeueReusableCell(rowType: StepperRow.self, cellType: StepperRowTableViewCell.self, formRow: formRow as! StepperRow, atIndexPath: indexPath) else {
                return UITableViewCell()
            }
            return cell
        case let formRow where formRow is SliderRow:
            guard let cell = dequeueReusableCell(rowType: SliderRow.self, cellType: SliderRowTableViewCell.self, formRow: formRow as! SliderRow, atIndexPath: indexPath) else {
                return UITableViewCell()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = sections[indexPath.section].rows.filter({ ($0 as? Row)?._isHiddenRow.value == false })[indexPath.row] as? Row else { return }
        
        if row._deselectWhenSelect {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        row.action?()
    }
    
    public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard let row = sections[indexPath.section].rows.filter({ ($0 as? Row)?._isHiddenRow.value == false })[indexPath.row] as? Row else { return }
        
        row.detailDisclosureButtonAction?()
    }
    
}
