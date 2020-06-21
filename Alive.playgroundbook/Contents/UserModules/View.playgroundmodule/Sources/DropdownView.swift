import UIKit
import Extensions
import Protocols

public class DropdownView: UIView {

    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(DropdownTableViewCell.self, forCellReuseIdentifier: DropdownTableViewCell.reuseIdentifier)
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

extension DropdownView: ViewCode {
   
    public func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    public func setupConstraints() {
        tableView
            .anchor(top: topAnchor)
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
            .anchor(bottom: bottomAnchor)
    }
}
