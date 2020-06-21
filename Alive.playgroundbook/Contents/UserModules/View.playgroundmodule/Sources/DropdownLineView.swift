import UIKit
import Extensions
import Protocols

public class DropdownLineView: UIView {
    
    public lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        return tap
    }()
    
    public lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
           
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
}

extension DropdownLineView: ViewCode {
    
    public func buildViewHierarchy() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(backImageView)
    }
    
    public func setupConstraints() {
        iconImageView
            .anchor(top: topAnchor, padding: 8)
            .anchor(leading: leadingAnchor, padding: 8)
            .anchor(widthConstant: 30)
            .anchor(heightConstant: 30)
        
        titleLabel
            .anchor(top: topAnchor, padding: 8)
            .anchor(leading: iconImageView.trailingAnchor, padding: 8)
            .anchor(centerY: iconImageView.centerYAnchor)
        
        backImageView
            .anchor(top: topAnchor, padding: 8)
            .anchor(leading: titleLabel.trailingAnchor, padding: 8)
            .anchor(trailing: trailingAnchor, padding: 8)
            .anchor(widthConstant: 25)
            .anchor(heightConstant: 25)
    }
    
    public func setupAdditionalConfigurantion() {
        backgroundColor = .clear
    }
}
