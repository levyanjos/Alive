
import UIKit

/// Protocol aimed to type safe during the colectionview or tableview dequeue cell. Any object that implements this protocol gonna has a variable called reuseIdentifier that turns the object type into a unique string identifier to be registered as the cell identifier.
public protocol Identifiable {
    static var reuseIdentifier: String { get }
}

extension Identifiable {
    public static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: Identifiable {}
