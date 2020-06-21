//#-hidden-code
import PlaygroundSupport

public let viewController = InitialViewController()
PlaygroundPage.current.setLiveView(viewController)

func makeItAlive() {
    viewController.setParalaxEffect(withBackRange: (minumum: -100.0, maximum: 100.0),
                                    withMiddleRange: (minumum: -15, maximum: 15),
                                    andFrontRange: (minumum: 40, maximum: -40))

    PlaygroundPage.current.wantsFullScreenLiveView = true
}
//#-end-hidden-code

/*:
Hey, there 👋!

Today, we’ll learn a little bit more about ART 👩‍🎨. In fact, with the advent of technology, new options and possibilities have emerged to facilitate and improve our experiences with the best in the world - In art, it would be no different. It is really often to see it in digital paintings, letterings, fly and much more.
 
Well, our valuable history contained in the arts of the past centuries could not be left behind, there are countless methods to create reinterpretations of the great paintings in a way more iterative. One of them I am going to teach you today, the Paralax art style.
 
The parallax style consists of creating a reinterpretation of art in which the user can interact with the resource in a more intuitive and immersive way. So, it looks like a simulation of reality but in the context of painting and the time when it was created.
 
Cool, huh?🤞 So, let's see how the painting Starry Night by the genius Vincent van Gogh would look like in this awesome style!
 
 * callout(Tip):
    After run my code, rotate your device like a compass to activate the gyroscope.
*/
//#-editable-code

//Click in run my core
makeItAlive()

//#-end-editable-code
/*:
Wow, I hope you enjoyed seeing how this beautiful painting looks when we apply this style. Now, shall we learn how to create this style of art? [Next page!](@next)
*/
