//
//  AnimatgionSegueViewController.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 25/01/2018.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit

class AnimatgionSegueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnClickToSegue(_ sender: Any) {
        let vc = AnimationTestViewController.fromStoryboard(.mainApp)
        pushNavigationController(vc)
    }
    
}
