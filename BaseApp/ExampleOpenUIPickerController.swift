//
//  ExampleOpenUIPickerController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/11/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

class ExampleOpenUIPickerController: UIViewController {

    
    @IBOutlet weak fileprivate var avatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction fileprivate func btnChooseAvatar(_ sender: Any) {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        picker.didCancel = { picker in
            picker.dismiss(animated: true, completion: nil)
        }
        picker.didFinishPickingMedia = { picker, image in
            self.avatar.image = image
            picker.dismiss(animated: true, completion: nil)
        }
        self.present(picker, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
