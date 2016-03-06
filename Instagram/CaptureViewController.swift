//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Michaela Foote on 3/5/16.
//  Copyright © 2016 Michaela Foote. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectPhoto(sender: AnyObject) {
        let picker = UIImagePickerController ()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func uploadPhoto(sender: AnyObject) {
        let currentUser = PFUser.currentUser()
        
        let scaledImage = self.resize(self.photoView.image!, newSize: CGSizeMake(750, 750))
        let imageData = UIImageJPEGRepresentation(scaledImage, 0)
        let imageFile = PFFile(name:"image.jpg", data:imageData!)
        let picture = PFObject(className: "Picture")
        picture["image"] = imageFile
        
        let post = PFObject(className: "Post")
        post["user"] = currentUser
        post["picture"] = picture
        post["caption"] = self.captionField.text
        post.saveInBackgroundWithBlock
            { (success: Bool, error: NSError?) -> Void in
                if let error = error
                {
                    print("Error saving post: \(error.description)")
                } else
                {
                    print("Post uploaded")
                    self.tabBarController!.selectedIndex = 0
                }
        }
        
        captionField.text = ""
        photoView.image = nil
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        picker.dismissViewControllerAnimated(true, completion: nil)
        photoView.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        
        
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
