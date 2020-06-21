import UIKit
import Extensions
import Protocols

public class DropdownButton: UIView {
    
    private var dropdownBottom: NSLayoutConstraint?
    
    private var isOpen = false
    
    public var delegate: UITableViewDelegate? = nil {
        willSet(newValue) {
            self.dropdownView.tableView.delegate = newValue
        }
    }
    
    public var dataSource: UITableViewDataSource? = nil {
        willSet(newValue) {
            self.dropdownView.tableView.dataSource = newValue
        }
    }
    
    public lazy var headerView: DropdownLineView = {
        let view = DropdownLineView()
        view.backgroundColor = .systemGray3
        view.backImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        view.iconImageView.image = UIImage(systemName: "square.stack.fill")
        view.titleLabel.text = "Layers"
        return view
    }()

    public lazy var dropdownView: DropdownView = {
        let view = DropdownView()
        view.tableView.delegate = delegate
        view.tableView.dataSource = dataSource
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen {
            dismissDropDown()
        } else {
            rotateArrow(angle: -0.5)
            isOpen.toggle()
            dropdownBottom?.isActive.toggle()
            if dropdownView.tableView.contentSize.height < 150 {
                dropdownBottom?.constant = 150 + 46
            } else {
                dropdownBottom?.constant = self.dropdownView.tableView.contentSize.height + 46
            }
            dropdownBottom?.isActive.toggle()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [unowned self] in
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    public func dismissDropDown() {
        rotateArrow(angle: 0)
        isOpen.toggle()
        dropdownBottom?.isActive.toggle()
        dropdownBottom?.constant = 46
        dropdownBottom?.isActive.toggle()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [unowned self] in
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func rotateArrow(angle: CGFloat) {
        headerView.backImageView.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    public func setSelectedItem(image: UIImage, title: String) {
        headerView.iconImageView.image = image
        headerView.titleLabel.text = title
        dismissDropDown()
    }
}

extension DropdownButton: ViewCode {
    
    public func buildViewHierarchy() {
        addSubview(headerView)
        addSubview(dropdownView)
    }
    
    public func setupConstraints() {
        
        headerView
            .anchor(top: topAnchor)
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
            .anchor(heightConstant: 46)
        
        dropdownView
            .anchor(top: headerView.bottomAnchor)
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
            .anchor(bottom: bottomAnchor)
        
        dropdownBottom =  self.heightAnchor.constraint(equalToConstant: 46)
        dropdownBottom?.isActive = true
        
    }
    
    public func setupAdditionalConfigurantion() {
        backgroundColor = .systemGroupedBackground
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
