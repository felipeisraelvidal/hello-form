import UIKit

protocol Identifiable {}

extension Identifiable where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Identifiable {}
