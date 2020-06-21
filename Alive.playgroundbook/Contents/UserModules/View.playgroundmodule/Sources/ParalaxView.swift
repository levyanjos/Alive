
import UIKit
import Extensions
import Protocols

/// Class reposible to create and View with paralax art
public class ParalaxView: UIView {
    
    private var contentView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    public let backgroundImageView: ParalaxImageView = {
        let imageView = ParalaxImageView(frame: CGRect.zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public let middleImageView: ParalaxImageView = {
        let imageView = ParalaxImageView(frame: CGRect.zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public let frontImageView: ParalaxImageView = {
        let imageView = ParalaxImageView(frame: CGRect.zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
}

extension ParalaxView: ViewCode {
    public func buildViewHierarchy() {
        addSubview(contentView)
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(middleImageView)
        contentView.addSubview(frontImageView)
    }
    
    public func setupConstraints() {
        contentView
            .anchor(top: topAnchor)
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
            .anchor(bottom: bottomAnchor)
        
        backgroundImageView
            .anchor(top: contentView.topAnchor)
            .anchor(leading: contentView.leadingAnchor)
            .anchor(trailing: contentView.trailingAnchor)
            .anchor(bottom: contentView.bottomAnchor)
        
        middleImageView
            .anchor(top: contentView.topAnchor)
            .anchor(leading: contentView.leadingAnchor)
            .anchor(trailing: contentView.trailingAnchor)
            .anchor(bottom: contentView.bottomAnchor)
        
        frontImageView
            .anchor(top: contentView.topAnchor)
            .anchor(leading: contentView.leadingAnchor)
            .anchor(trailing: contentView.trailingAnchor)
            .anchor(bottom: contentView.bottomAnchor)
    }
    
    public func setupAdditionalConfigurantion() {
        backgroundColor = .white
    }
}
