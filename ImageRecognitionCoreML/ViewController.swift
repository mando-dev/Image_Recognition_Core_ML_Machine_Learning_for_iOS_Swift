import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pictureImageView :UIImageView!
    @IBOutlet weak var titleLabel :UILabel!
    
    //creatting an instance or propoerty of the inception_v3 class
    //the () itnitializes the InceptionV3
    private var model :Inceptionv3 = Inceptionv3()
    
    let images = ["cat.jpeg", "dog.jpeg", "rat.jpeg", "banana.jpeg"]
    //we have to keep track of the index of where we are inside the array. making a variable index whcih will initilaize from 0
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
      }
    @IBAction func nextButtonPressed() {
        //becasue the index can go much longer...It will return to the initial position by setting index = 0 below. we are restriciting going past the -1, meaning that at the end of the pics it will reset to original pic. images was first defined in line 12
        if index > self.images.count - 1 {
            index = 0
        }
        
        //we want to chnage the image whenever the 'next'button is pressed. assigning image to the next 0 we saw? we are passing in the [index]
        let img = UIImage(named: images[index])
        //once we have the image, we can assign the image to the picture image view. Our image instance below is now stored in img and now we will apply the extension function we created before. "pictureImageView" is the image outlet
        self.pictureImageView.image = img
            //make sure you are incrementing the index, otherwise it wont move on to the next picture, in other words if you dont update the index then its always going to be 0
        let resizedImage =  img?.resizeTo(size: CGSize(width: 299, height: 299))
        //once it is initialized () we can pass in our resizedImage and the Inception model is going to tell us whether it thinks the pic is a cat/dog
        // we created a function that will create UIImage into CV pixel buffer
        let buffer = resizedImage?.toBuffer()
        // once its converted we can now pass it in to get a prediction. We are passing in Buffer
        let prediction = try! self.model.prediction(image: buffer!)
        //displaying title of prediction
        self.titleLabel.text = prediction.classLabel
        
        index = index + 1
        
    }

}

