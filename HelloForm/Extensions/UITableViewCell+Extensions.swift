import UIKit

extension UITableViewCell {
    
    var tableView: UITableView? {
        return parentView(of: UITableView.self)
    }
    
}
