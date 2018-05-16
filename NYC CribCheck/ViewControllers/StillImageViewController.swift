//
//  StillImageViewController.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/4/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit

class StillImageViewController: UIViewController {
    
    public static func storyboardInstance(withName name: String) -> StillImageViewController {
        let storyboard = UIStoryboard(name: "DisclaimerAndTutorial", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! StillImageViewController
        return vc
    }

    @IBAction func dismissTutorial(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "dismissedTutorial")
        if let pageVC = self.parent as? TutorialPageViewController {
            pageVC.dismiss(animated: true, completion: nil)
        } else {
            // TODO: - handle the button not working
            print("no")
        }
    }
}
