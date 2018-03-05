//
//  TutorialPageViewController.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/4/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {
    
    // var vc = StillImageViewController.storyboardInstance(withName: "One")
    
    private(set) lazy var orderedViewControllers: [StillImageViewController] = {
        return [self.simpleViewController("One"),
                self.simpleViewController("Two"),
                self.simpleViewController("Three"),
                self.simpleViewController("Four")]
    }()
    
    private func simpleViewController(_ name: String) -> StillImageViewController {
        return StillImageViewController.storyboardInstance(withName: name)
//        return UIStoryboard(name: "Main", bundle: nil) .
//            instantiateViewControllerWithIdentifier("\(color)ViewController")
//        self.control
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
//        setViewControllers(orderedViewControllers, direction: .forward, animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        //corrects scrollview frame to allow for full-screen view controller pages
        for subView in self.view.subviews {
            if subView is UIScrollView {
                subView.frame = self.view.bounds
            }
        }
        super.viewDidLayoutSubviews()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
//        let vc = StillImageViewController.storyboardInstance(withName: "One")
//        self.setViewControllers([vc], direction: .forward, animated: false, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public static func storyboardInstance() -> TutorialPageViewController {
        let storyboard = UIStoryboard(name: "DisclaimerAndTutorial", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TutorialPageViewController") as! TutorialPageViewController
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

// MARK: UIPageViewControllerDataSource

extension TutorialPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        return nil
        guard let viewController = viewController as? StillImageViewController else {
            return nil
        }
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print(self.orderedViewControllers.index(of: viewController as! StillImageViewController))
        //        return nil
//        print(orderedV)
        dump(viewController)
        guard let viewController = viewController as? StillImageViewController else {
            return nil
        }
        print(viewController.view.tag)
        print(viewController === orderedViewControllers[0])
        print(viewController === orderedViewControllers[1])
        print(viewController === orderedViewControllers[2])
        print(orderedViewControllers.index(of: viewController))
        print(orderedViewControllers.count)
        dump(orderedViewControllers)
        dump(viewController)
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first as? StillImageViewController,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    
//    func pageViewController(pageViewController: UIPageViewController,
//                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
//        return nil
//    }
//
//    func pageViewController(pageViewController: UIPageViewController,
//                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
//        return nil
//    }
    
}
