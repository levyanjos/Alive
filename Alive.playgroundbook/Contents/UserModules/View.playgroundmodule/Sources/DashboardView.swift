import UIKit
import Extensions
import Protocols
import PlaygroundSupport

public class DashboardView: UIView {

    private var contentView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.transform3D = CATransform3DMakeScale(0.75, 0.75, 1)
        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.layer.borderWidth = 2
        return view
    }()
       
    public let backgroundImageView: ParalaxImageView = {
        let imageView = ParalaxImageView(frame: CGRect.zero)
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
   
    public let middleImageView: ParalaxImageView = {
        let imageView = ParalaxImageView(frame: CGRect.zero)
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
   
    public let frontImageView: ParalaxImageView = {
        let imageView = ParalaxImageView(frame: CGRect.zero)
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
     
    public lazy var dropdownButton: DropdownButton = {
        let dropdownButton = DropdownButton()
        return dropdownButton
    }()
    
    public lazy var galeryButton: DropdownButton = {
        let view = DropdownButton()
        view.backgroundColor = .systemGray3
        view.setSelectedItem(image:  UIImage(systemName: "camera.on.rectangle.fill")!, title: "Galery")
        view.isHidden = true
        return view
    }()
    
    public lazy var drawButton: DropdownLineView = {
        let view = DropdownLineView()
        view.backgroundColor = .systemGray3
        view.iconImageView.image = UIImage(systemName: "paintbrush.fill")
        view.titleLabel.text = "Draw"
        view.layer.cornerRadius = 10
        view.backImageView.removeFromSuperview()
        view.isUserInteractionEnabled = true
        view.isHidden = true
        view.clipsToBounds = true
        view.addGestureRecognizer(view.tapGesture)
        return view
    }()
    
    public lazy var applyFxButton: DropdownLineView = {
        let view = DropdownLineView()
        view.backgroundColor = .systemGray3
        view.iconImageView.image = UIImage(systemName: "perspective")
        view.titleLabel.text = "Apply Effect"
        view.layer.cornerRadius = 10
        view.backImageView.removeFromSuperview()
        view.isUserInteractionEnabled = true
        view.isHidden = true
        view.clipsToBounds = true
        view.addGestureRecognizer(view.tapGesture)
        return view
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

extension DashboardView: ViewCode, PlaygroundLiveViewSafeAreaContainer {
    
    public func buildViewHierarchy() {
        addSubview(contentView)
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(middleImageView)
        contentView.addSubview(frontImageView)
        addSubview(dropdownButton)
        addSubview(drawButton)
        addSubview(galeryButton)
        addSubview(applyFxButton)
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
        
        dropdownButton
            .anchor(top: liveViewSafeAreaGuide.topAnchor, padding: 8)
            .anchor(leading: leadingAnchor, padding: 8)
            .anchor(widthConstant: 148)
        
        drawButton
            .anchor(top: liveViewSafeAreaGuide.topAnchor, padding: 8)
            .anchor(trailing: trailingAnchor, padding: 8)
            .anchor(widthConstant: 116)
            .anchor(heightConstant: 46)
        
        galeryButton
            .anchor(top: liveViewSafeAreaGuide.topAnchor, padding: 8)
            .anchor(trailing: drawButton.leadingAnchor, padding: 8)
            .anchor(widthConstant: 148)
        
        applyFxButton
            .anchor(bottom: bottomAnchor, padding: 16)
            .anchor(trailing: trailingAnchor, padding: 8)
            .anchor(widthConstant: 156)
            .anchor(heightConstant: 46)
    }
    
    public func setupAdditionalConfigurantion() {
        backgroundColor = .white
    }
}
