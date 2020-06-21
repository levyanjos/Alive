//#-hidden-code
import PlaygroundSupport
import UIKit

public let viewController = TheoryController()
PlaygroundPage.current.setLiveView(viewController)

var backgoundImageOffsetRange: ParalaxImageView.imageRange = (0,0)
var middleImageOffsetRange: ParalaxImageView.imageRange = (0,0)
var frontImageOffsetRange: ParalaxImageView.imageRange = (0,0)

var showPrespective: Bool = false
let view = UIView()

//#-end-hidden-code
/*:
Imagine the following, this technique consists of separating the elements of the painting in 3 layers - Background, Middle and Front - or more. To a better understanding, imagine that the depth or distance that the element appears to be in relation to you will determine which layer it is in: `Front` are the closest elements - On a starry night was the tree, `Middle` are those between the front and the back - the stars, and `Back` would be the most distant elements like the background.
    
 Indeed, these Layers are positioned in the geometric center of a Cartesian plane and, from the device's gyroscope data, are moved up or down on the positive or negative points that are defined from that plane according to an estimated maximum and minimum value. You can see this in the figure below.
 
 ![Coordinator](cp.png)

 
 Cool, that's the theory behind that style. What about putting into practice what we just learned?
 
 
 * callout(Tip):
    If you prefer, set the minimum and maximum value for each layer, but for the visualisation will be more optimised with these values.
 */

// minimum and maximum will be set to axis X and Y axis of the Cartesian plane
//Click in Run the my code
backgoundImageOffsetRange = (minumum:/*#-editable-code*/-100/*#-end-editable-code*/, maximum: /*#-editable-code*/100/*#-end-editable-code*/)

middleImageOffsetRange = (minumum:/*#-editable-code*/-15/*#-end-editable-code*/, maximum: /*#-editable-code*/15/*#-end-editable-code*/)

frontImageOffsetRange = (minumum:/*#-editable-code*/40/*#-end-editable-code*/, maximum: /*#-editable-code*/-40/*#-end-editable-code*/)

//#-hidden-code
    viewController.setParalaxEffect(withBackRange: backgoundImageOffsetRange,
                          withMiddleRange: middleImageOffsetRange,
                          andFrontRange: frontImageOffsetRange)
//#-end-hidden-code
/*:

Great, now that you've run the code and moved your device to see how the layers respond to the values, what about seeing how this happens in perspective?
*/

//Change the value of the boolean below to true and then run the code
showPrespective = /*#-editable-code*/false/*#-end-editable-code*/

//#-hidden-code
   if showPrespective {
        viewController.paralaxView.backgroundImageView.addAnimationInZ(transition: 100)
        viewController.paralaxView.middleImageView.addAnimationInZ(transition: 50)
        viewController.paralaxView.frontImageView.addAnimationInZ(transition: 0)
        
    } else {
        viewController.paralaxView.backgroundImageView.returnToIdentity()
        viewController.paralaxView.middleImageView.returnToIdentity()
        viewController.paralaxView.frontImageView.returnToIdentity()
    }
//#-end-hidden-code
/*:
Cool, now we apply the theory and you already know how to create this style of art. If you are curious about how it works in `Swift`, the implementation below shows how we can create this effect in a quick and intuitive way with few lines. Let's go to the [next page!](@next)
*/

func addParalaxEffect(withRange value: (minumum: Double, maximum: Double)) {
    //Add range values to X and Y
    let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
    horizontal.minimumRelativeValue = value.minumum
    horizontal.maximumRelativeValue = value.maximum

    let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
    vertical.minimumRelativeValue = value.minumum
    vertical.maximumRelativeValue = value.maximum
    
    //Create the effect and add to the image
    let group = UIMotionEffectGroup()
    group.motionEffects = [horizontal, vertical]
    view.addMotionEffect(group)
}
