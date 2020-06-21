import UIKit
import View

public class InitialViewController: UIViewController {
    
    public var paralaxView: ParalaxView = {
        let view = ParalaxView()
        view.backgroundImageView.image = UIImage(named: "back - 0")
        view.middleImageView.image = UIImage(named: "middle - 0")
        view.frontImageView.image = UIImage(named: "front - 0")
        return view
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view = paralaxView
        // Do any additional setup after loading the view.
        paralaxView.backgroundImageView.identity = CATransform3DMakeScale(0.85, 0.85, 1)
        paralaxView.middleImageView.identity = CATransform3DMakeScale(0.85, 0.85, 1)
        paralaxView.frontImageView.identity = CATransform3DMakeScale(0.85, 0.85, 1)
    }
    
    
    
    public func setParalaxEffect(withBackRange backRange: ParalaxImageView.imageRange,
                                    withMiddleRange middleRange: ParalaxImageView.imageRange,
                                    andFrontRange frontRange: ParalaxImageView.imageRange) {
           
       paralaxView.backgroundImageView.addParalaxEffect(withRange: backRange)
       paralaxView.middleImageView.addParalaxEffect(withRange: middleRange)
       paralaxView.frontImageView.addParalaxEffect(withRange: frontRange)
    }
}
