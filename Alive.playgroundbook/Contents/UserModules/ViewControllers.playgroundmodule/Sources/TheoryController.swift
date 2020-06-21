import UIKit
import View

public class TheoryController: UIViewController {
    
    public var paralaxView: ParalaxView = {
        let view = ParalaxView()
        return view
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view = paralaxView
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        //setting up the images
        paralaxView.backgroundImageView.image = UIImage(systemName: "app.fill")
        paralaxView.backgroundImageView.tintColor = #colorLiteral(red: 0.02352941176, green: 0.1098039216, blue: 0.1921568627, alpha: 1)
        paralaxView.backgroundImageView.identity = CATransform3DMakeScale(0.75, 0.75, 1)

        paralaxView.middleImageView.image = UIImage(systemName: "circle.fill")
        paralaxView.middleImageView.tintColor = #colorLiteral(red: 0, green: 0.1450980392, blue: 0.9333333333, alpha: 1)
        paralaxView.middleImageView.identity = CATransform3DMakeScale(0.5, 0.5, 1)
           
        paralaxView.frontImageView.image = UIImage(systemName: "triangle.fill")
        paralaxView.frontImageView.tintColor = #colorLiteral(red: 0.2235294118, green: 0.7607843137, blue: 0.9803921569, alpha: 1)
        paralaxView.frontImageView.identity = CATransform3DMakeScale(0.25, 0.25, 1)
    }
       
    public func setParalaxEffect(withBackRange backRange: ParalaxImageView.imageRange,
                                    withMiddleRange middleRange: ParalaxImageView.imageRange,
                                    andFrontRange frontRange: ParalaxImageView.imageRange) {
           
       paralaxView.backgroundImageView.addParalaxEffect(withRange: backRange)
       paralaxView.middleImageView.addParalaxEffect(withRange: middleRange)
       paralaxView.frontImageView.addParalaxEffect(withRange: frontRange)
    }
}
