import UIKit
import Extensions
import Protocols

public class DropdownTableViewCell: UITableViewCell {

    public lazy var dropdownLineView: DropdownLineView = {
        let imageView = DropdownLineView()
        
        return imageView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
}

extension DropdownTableViewCell: ViewCode {
    
    public func buildViewHierarchy() {
        addSubview(dropdownLineView)
    }
    
    public func setupConstraints() {
        dropdownLineView
            .anchor(top: topAnchor)
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
            .anchor(bottom: bottomAnchor)
    
    }
    
    public func setupAdditionalConfigurantion() {
        backgroundColor = .clear
    }
}

