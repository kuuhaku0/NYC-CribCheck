//
//  StillImageViewController.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/4/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit

class StillImageViewController: UIViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public static func storyboardInstance(withName name: String) -> StillImageViewController {
        let storyboard = UIStoryboard(name: "DisclaimerAndTutorial", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! StillImageViewController
        return vc
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
