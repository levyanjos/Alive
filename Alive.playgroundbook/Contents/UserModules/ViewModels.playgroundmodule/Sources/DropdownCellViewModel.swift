import UIKit
import View

public class DropdownCellViewModel {
    
    public var isEdited: EditedKind = .none
    
    public var selectedImagePath: IndexPath? = nil

    public var icon: String
    public var kind: Item.imageType
    
    public init(item: Item) {
        self.icon = item.icon
        self.kind = item.itemType
    }
    
    public enum EditedKind {
        case camera
        case draw
        case galery
        case none
    }
}
