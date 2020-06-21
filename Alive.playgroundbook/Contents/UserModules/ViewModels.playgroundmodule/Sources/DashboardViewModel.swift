import UIKit
import View

public class DashboardViewModel {
    
    // MARK: - Typealias
    public typealias BindingClosure = () -> Void
    public typealias itemClosure = ((DropdownCellViewModel?) -> Void)
    public typealias EditedKindClosure = (DropdownCellViewModel.EditedKind) -> Void
    
    // MARK: - Binding closures
    public var updateItemClosure: itemClosure?
    public var updateToolwithEditedKindClosure: EditedKindClosure?
    public var applyEffectClousure: BindingClosure?

    // MARK: - Control Variables
    public var selectedItem: DropdownCellViewModel? {
        willSet(newValue) {
            updateItemClosure?(newValue)
        }
    }
        
    public var selectedIndexPath: IndexPath?
    
    public var items: [Item]
    
    public var isAppliedFX = false
    
    public var dropdownCellViewModel: [DropdownCellViewModel]
   
    // MARK: - Initializer & functions
    public init(items: [Item] = []) {
        self.items = items
        dropdownCellViewModel = items.map({DropdownCellViewModel(item: $0)})
    }
    
    @objc public func cameraButtonDidTapped(_ tap: UITapGestureRecognizer) {
        updateToolwithEditedKindClosure?(.camera)
    }
    
    @objc public func applyFXButtonDidTapped(_ tap: UITapGestureRecognizer) {
        applyEffectClousure?()
    }
    
    @objc public func drawButtonDidTapped(_ tap: UITapGestureRecognizer) {
        updateToolwithEditedKindClosure?(.draw)
    }
}

public struct Item {
    public var icon: String
    public var itemType: imageType
    
    public init(icon: String, itemType: imageType) {
        self.icon = icon
        self.itemType = itemType
    }
    
    public enum imageType: String {
        case selfie
        case back
        case middle
        case front
    }
}

