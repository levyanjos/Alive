import UIKit
import View
import ViewModels
import Extensions

public class DashBoardViewController: UIViewController {

    private var viewModel: DashboardViewModel = {
        let background = Item(icon: "app.fill", itemType: .back)
        let middle = Item(icon: "circle.fill", itemType: .middle)
        let front = Item(icon: "triangle.fill", itemType: .front)
        let selfie = Item(icon: "person.crop.square.fill", itemType: .selfie)

        let viewModel = DashboardViewModel(items: [front, middle, background])
        return viewModel
    }()
    
    public var dashboardView: DashboardView = {
        let view = DashboardView()
        return view
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view = dashboardView
        // Do any additional setup after loading the view.
        dashboardView.dropdownButton.delegate = self
        dashboardView.dropdownButton.dataSource = self
        
        dashboardView.galeryButton.delegate = self
        dashboardView.galeryButton.dataSource = self
    
        dashboardView.drawButton.tapGesture.addTarget(viewModel, action: #selector(viewModel.drawButtonDidTapped(_:)))
        dashboardView.applyFxButton.tapGesture.addTarget(viewModel, action: #selector(viewModel.applyFXButtonDidTapped(_:)))

    }
    
    public override func viewWillAppear(_ animated: Bool) {
                
        viewModel.updateItemClosure = { [unowned self] item in
            guard let item = item,
                    let image = UIImage(systemName: item.icon)
            else {
                return
            }
            if item.kind == .selfie {
                self.dashboardView.dropdownButton.setSelectedItem(image: image, title: item.kind.rawValue.firstUppercased)
                self.dashboardView.drawButton.isHidden = false
                self.dashboardView.applyFxButton.isHidden = false
                self.dashboardView.galeryButton.isHidden = true
                self.dashboardView.drawButton.iconImageView.image = UIImage(systemName: "camera.fill")
                self.dashboardView.drawButton.titleLabel.text = "Camera"
                self.dashboardView.drawButton.tapGesture.removeTarget(self.viewModel, action: #selector(self.viewModel.drawButtonDidTapped(_:)))
                self.dashboardView.drawButton.tapGesture.addTarget(self.viewModel, action: #selector(self.viewModel.cameraButtonDidTapped(_:)))
            } else {
                self.dashboardView.dropdownButton.setSelectedItem(image: image, title: item.kind.rawValue.firstUppercased)
                self.dashboardView.drawButton.isHidden = false
                self.dashboardView.galeryButton.isHidden = false
                self.dashboardView.applyFxButton.isHidden = false
                self.dashboardView.drawButton.iconImageView.image = UIImage(systemName: "paintbrush.fill")
                self.dashboardView.drawButton.titleLabel.text = "Draw"
                self.dashboardView.drawButton.tapGesture.removeTarget(self.viewModel, action: #selector(self.viewModel.cameraButtonDidTapped(_:)))
                self.dashboardView.drawButton.tapGesture.addTarget(self.viewModel, action: #selector(self.viewModel.drawButtonDidTapped(_:)))
            }
            self.viewModel.updateToolwithEditedKindClosure?(item.isEdited)
        }
        
        viewModel.updateToolwithEditedKindClosure = { [weak self] configuration in
            guard let indexPath = self?.viewModel.selectedIndexPath,
                let item = self?.viewModel.dropdownCellViewModel[indexPath.row] else { return }
            if configuration == DropdownCellViewModel.EditedKind.none {
                self?.setUPCanvas(configuration, initialize: true)
                item.isEdited = .none
            } else if item.isEdited != configuration && item.isEdited != DropdownCellViewModel.EditedKind.none {
               if item.isEdited == .galery && configuration == .draw {
                   self?.setUPCanvas(configuration, initialize: true, insertCanva: true)
               } else {
                   self?.setUPCanvas(configuration, initialize: true)
               }
               item.isEdited  = configuration
            } else if item.isEdited != configuration &&  configuration == DropdownCellViewModel.EditedKind.draw {
                self?.setUPCanvas(configuration, insertCanva: true)
                item.isEdited = .draw
            } else {
                 self?.setUPCanvas(configuration)
            }
        }
        
        viewModel.applyEffectClousure = { [unowned self] in
            self.viewModel.isAppliedFX.toggle()
            if self.viewModel.isAppliedFX {
                self.dashboardView.applyFxButton.backgroundColor = .systemBlue
                self.dashboardView.dropdownButton.isHidden = true
                self.dashboardView.drawButton.isHidden = true
                self.dashboardView.galeryButton.isHidden = true
                self.dashboardView.backgroundImageView.addParalaxEffect(withRange: (minumum: -100.0, maximum: 100.0))
                self.dashboardView.middleImageView.addParalaxEffect(withRange: (minumum: -15, maximum: 15))
                self.dashboardView.frontImageView.addParalaxEffect(withRange: (minumum: -40, maximum: 40))
            } else {
                self.dashboardView.applyFxButton.backgroundColor = .systemGray3
                self.dashboardView.dropdownButton.isHidden = false
                self.dashboardView.drawButton.isHidden = false
                self.dashboardView.galeryButton.isHidden = false
                self.dashboardView.backgroundImageView.removeParalaxEffect()
                self.dashboardView.middleImageView.removeParalaxEffect()
                self.dashboardView.frontImageView.removeParalaxEffect()
            }
        }
    }
    
    private func setUPCanvas(_ configuration: DropdownCellViewModel.EditedKind, initialize: Bool = false, insertCanva: Bool = false) {
        guard let indexPath = self.viewModel.selectedIndexPath else { return }
        switch configuration {
        case .camera:
            self.dashboardView.drawButton.backgroundColor = .systemBlue
            self.dashboardView.galeryButton.headerView.backgroundColor = .systemGray3
            self.dashboardView.galeryButton.headerView.backImageView.tintColor = .systemBlue
        case .draw:
            self.dashboardView.drawButton.backgroundColor = .systemBlue
            self.dashboardView.galeryButton.headerView.backgroundColor = .systemGray3
            self.dashboardView.galeryButton.headerView.backImageView.tintColor = .systemBlue
            switch self.viewModel.dropdownCellViewModel[indexPath.row].kind {
                case .selfie:
                    break
                case .back:
                    self.updateCanvaHit(true, false, false)
                    if insertCanva {
                        self.dashboardView.backgroundImageView.insertCanvas()
                    }
                case .middle:
                    self.updateCanvaHit(false, true, false)
                    if insertCanva {
                        self.dashboardView.middleImageView.insertCanvas()
                    }
                case .front:
                    self.updateCanvaHit(false, false, true)
                    if insertCanva {
                        self.dashboardView.frontImageView.insertCanvas()
                    }
            }
            
        case .galery:
            self.dashboardView.drawButton.backgroundColor = .systemGray3
            self.dashboardView.galeryButton.headerView.backgroundColor = .systemBlue
            self.dashboardView.galeryButton.headerView.backImageView.tintColor = .white
            let cellViewModel = self.viewModel.dropdownCellViewModel[indexPath.row]
            switch self.viewModel.dropdownCellViewModel[indexPath.row].kind {
            case .selfie: break
            case .back:
                if initialize {
                    self.dashboardView.backgroundImageView.removeCanvas()
                }
                guard let cellIndexPath = cellViewModel.selectedImagePath else { return }

                self.dashboardView.backgroundImageView.image = UIImage(named: "back - \(cellIndexPath.row)")
            case .middle:
                if initialize {
                    self.dashboardView.middleImageView.removeCanvas()
                }
                guard let cellIndexPath = cellViewModel.selectedImagePath else { return }

                self.dashboardView.middleImageView.image = UIImage(named: "middle - \(cellIndexPath.row)")
            case .front:
                if initialize {
                    self.dashboardView.frontImageView.removeCanvas()
                }
                guard let cellIndexPath = cellViewModel.selectedImagePath else { return }

                self.dashboardView.frontImageView.image = UIImage(named: "front - \(cellIndexPath.row)")
            }
                
        case .none:
            self.dashboardView.drawButton.backgroundColor = .systemGray3
            self.dashboardView.galeryButton.headerView.backgroundColor = .systemGray3
            self.dashboardView.galeryButton.headerView.backImageView.tintColor = .systemBlue
            self.updateCanvaHit(false, false, false)
        }
    }
        
    private func updateCanvaHit(_ back: Bool, _ middle: Bool, _ front: Bool) {
        self.dashboardView.backgroundImageView.hitShouldBeHere = back
        self.dashboardView.frontImageView.hitShouldBeHere = front
        self.dashboardView.middleImageView.hitShouldBeHere = middle
    }
}

extension DashBoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.dashboardView.dropdownButton.dropdownView.tableView {
            return viewModel.dropdownCellViewModel.count

        }
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.dashboardView.dropdownButton.dropdownView.tableView {
            let cellViewModel = viewModel.dropdownCellViewModel[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DropdownTableViewCell.reuseIdentifier, for: indexPath) as? DropdownTableViewCell else {
                return UITableViewCell()
            }
            cell.dropdownLineView.iconImageView.image = UIImage(systemName: cellViewModel.icon)
            cell.dropdownLineView.titleLabel.text = cellViewModel.kind.rawValue.firstUppercased
            
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.reuseIdentifier, for: indexPath) as? ImageTableViewCell,
            let selectedItem = self.viewModel.selectedItem else { return UITableViewCell() }
        
        switch selectedItem.kind {
        case .selfie:
            return cell
        case .back:
            cell.artImageView.image = UIImage(named: "back - \(indexPath.row)")
        case .middle:
            cell.artImageView.image = UIImage(named: "middle - \(indexPath.row)")
        case .front:
            cell.artImageView.image = UIImage(named: "front - \(indexPath.row)")
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if tableView == self.dashboardView.dropdownButton.dropdownView.tableView {
            viewModel.selectedIndexPath = indexPath
            viewModel.selectedItem = viewModel.dropdownCellViewModel[indexPath.row]
            dashboardView.galeryButton.dropdownView.tableView.reloadData()
         } else {
            guard let selectedIndexPath = viewModel.selectedIndexPath else { return }
            self.viewModel.dropdownCellViewModel[selectedIndexPath.row].selectedImagePath = indexPath
            viewModel.updateToolwithEditedKindClosure?(.galery)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView != self.dashboardView.dropdownButton.dropdownView.tableView {
            return 100
        }
        return 54
    }
}
