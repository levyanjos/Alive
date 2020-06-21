import UIKit
import Extensions
import Protocols

public class ImageTableViewCell: UITableViewCell {
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        artImageView.image = nil
    }

    public lazy var artImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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

extension ImageTableViewCell: ViewCode {
    
    public func buildViewHierarchy() {
        addSubview(artImageView)
    }
    
    public func setupConstraints() {
        artImageView
            .anchor(top: topAnchor, padding: 8)
            .anchor(leading: leadingAnchor, padding: 8)
            .anchor(trailing: trailingAnchor, padding: 8)
            .anchor(bottom: bottomAnchor, padding: 8)
    }
    
    public func setupAdditionalConfigurantion() {
        backgroundColor = .clear
    }
}
