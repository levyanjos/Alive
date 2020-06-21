import UIKit
import PencilKit
import Extensions
import Protocols

public class ParalaxImageView: UIImageView {
    
    private lazy var canvasView: PKCanvasView = {
        let canvas = PKCanvasView()
        canvas.contentMode = .scaleAspectFill
        return canvas
    }()
    
    public var hitShouldBeHere: Bool = false
    
    public typealias imageRange = (minumum: Double, maximum: Double)
    
    public var identity: CATransform3D = CATransform3DMakeScale(1, 1, 1) {
        willSet(newValue)  {
            self.transform3D = newValue
        }
    }
    
    convenience public init(frame: CGRect = CGRect.zero,
                     image: UIImage,
                     tintColor: UIColor,
                     identity: CATransform3D = CATransform3DMakeScale(1, 1, 1)) {
        self.init(frame: frame)
        self.image = image
        self.identity = identity
        self.transform3D = identity
        self.tintColor = tintColor
        
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func addParalaxEffect(withRange value: imageRange) {
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = value.minumum
        horizontal.maximumRelativeValue = value.maximum

        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = value.minumum
        vertical.maximumRelativeValue = value.maximum

        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        self.addMotionEffect(group)
    }
       
    public func removeParalaxEffect() {
        self.motionEffects.removeAll()
    }
    
    
    public func addAnimationInZ(transition: CGFloat) {
        UIImageView.animate(withDuration: 1) { [unowned self] in
            self.transform3D = CATransform3DConcat(CATransform3DConcat(self.identity, CATransform3DMakeRotation(1.5, 0, 1, 0)), CATransform3DMakeTranslation(-transition, 0, 0))
        }
    }
    
    public func returnToIdentity() {
        UIImageView.animate(withDuration: 1) { [unowned self] in
            self.transform3D = self.identity
        }
    }
    
    public func insertCanvas() {
        addSubview(canvasView)
        canvasView
            .anchor(top: topAnchor)
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
            .anchor(bottom: bottomAnchor)
        
        guard
            let window = window,
            let toolPicker = PKToolPicker.shared(for: window) else { return }

        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.backgroundColor = UIColor.white.withAlphaComponent(0)
        canvasView.allowsFingerDrawing = true
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
    
    public func removeCanvas() {
        canvasView.resignFirstResponder()
        canvasView.removeFromSuperview()
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)

        if hitShouldBeHere {
            return view

        }
        return nil
    }
}
