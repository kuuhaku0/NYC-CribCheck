//
//  ViewController1.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialButtons
import SVProgressHUD

class SearchFormViewController: UIViewController {
    var borough = ""
    var violationsArr = [Violation]()
    var bgImage: UIImage!
    
    @IBOutlet weak var houseNumberTextfield: MDCTextField!
    @IBOutlet weak var streetNameTextfield: MDCTextField!
    @IBOutlet weak var apartmentTextfield: MDCTextField!
    @IBOutlet weak var zipCodeTextfield: MDCTextField!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var hnTFController: MDCTextInputControllerLegacyDefault!
    var snTFController: MDCTextInputControllerLegacyDefault!
    var aptTFController: MDCTextInputControllerLegacyDefault!
    var zcTFController: MDCTextInputControllerLegacyDefault!
    
    @IBOutlet weak var searchButton:MDCRaisedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForKeyboardNotifications()
        addDismisKeyboardOnTap()
        
        houseNumberTextfield.textColor = .white
        streetNameTextfield.textColor = .white
        apartmentTextfield.textColor = .white
        zipCodeTextfield.textColor = .white
        houseNumberTextfield.font = UIFont.systemFont(ofSize: 20)
        streetNameTextfield.font = UIFont.systemFont(ofSize: 20)
        apartmentTextfield.font = UIFont.systemFont(ofSize: 20)
        zipCodeTextfield.font = UIFont.systemFont(ofSize: 20)
        
        
        navigationItem.title = borough
        houseNumberTextfield.delegate = self
        houseNumberTextfield.tag = 1
        streetNameTextfield.delegate = self
        streetNameTextfield.tag = 2
        apartmentTextfield.delegate = self
        apartmentTextfield.tag = 3
        zipCodeTextfield.delegate = self
        zipCodeTextfield.tag = 4
        
        hnTFController = MDCTextInputControllerLegacyDefault(textInput: houseNumberTextfield)
        snTFController = MDCTextInputControllerLegacyDefault(textInput: streetNameTextfield)
        aptTFController = MDCTextInputControllerLegacyDefault(textInput: apartmentTextfield)
        zcTFController = MDCTextInputControllerLegacyDefault(textInput: zipCodeTextfield)
        
        hnTFController.errorColor = UIColor.white
        snTFController.errorColor = UIColor.white
        aptTFController.errorColor = UIColor.white
        zcTFController.errorColor = UIColor.white
        hnTFController.normalColor = UIColor.white
        snTFController.normalColor = UIColor.white
        aptTFController.normalColor = UIColor.white
        zcTFController.normalColor = UIColor.white
        hnTFController.floatingPlaceholderNormalColor = UIColor.white
        snTFController.floatingPlaceholderNormalColor = UIColor.white
        aptTFController.floatingPlaceholderNormalColor = UIColor.white
        zcTFController.floatingPlaceholderNormalColor = UIColor.white
        hnTFController.inlinePlaceholderColor = UIColor.white
        snTFController.inlinePlaceholderColor = UIColor.white
        aptTFController.inlinePlaceholderColor = UIColor.white
        zcTFController.inlinePlaceholderColor = UIColor.white
        hnTFController.inlinePlaceholderFont = UIFont.systemFont(ofSize: 20)
        snTFController.inlinePlaceholderFont = UIFont.systemFont(ofSize: 20)
        aptTFController.inlinePlaceholderFont = UIFont.systemFont(ofSize: 20)
        zcTFController.inlinePlaceholderFont = UIFont.systemFont(ofSize: 20)
        
        
        
        hnTFController.setErrorText("i.e. 1234", errorAccessibilityValue: nil)
        snTFController.setErrorText("i.e. East 48 Street", errorAccessibilityValue: nil)
        aptTFController.setErrorText("*optional i.e. 2R ", errorAccessibilityValue: nil)
        zcTFController.setErrorText("i.e. 12345", errorAccessibilityValue: nil)
        
        hnTFController.isFloatingEnabled = true
        snTFController.isFloatingEnabled = true
        aptTFController.isFloatingEnabled = true
        zcTFController.isFloatingEnabled = true
        
        searchButton.isEnabled = false
        searchButton.setBackgroundColor(UIColor.white)
        searchButton.setTitleColor(UIColor.black, for: .normal)
        
        houseNumberTextfield.autocorrectionType = .no
        houseNumberTextfield.autocapitalizationType = .none
        streetNameTextfield.autocorrectionType = .no
        streetNameTextfield.autocapitalizationType = .words
        apartmentTextfield.autocorrectionType = .no
        apartmentTextfield.autocapitalizationType = .none
        zipCodeTextfield.autocorrectionType = .no
        zipCodeTextfield.autocapitalizationType = .none
        
        backgroundImageView.image = bgImage
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    var locationRequest: LocationRequest!
    private func search() {
        guard searchButton.isEnabled else {
            return
        }
        guard let houseNumber = houseNumberTextfield.text else {
            showAlert(title: "Missing Input", message: "All Fields must be filled in")
            return
        }
        guard let streetName = streetNameTextfield.text?.uppercased()  else {
            showAlert(title: "Missing Input", message: "All Fields must be filled in")
            return
        }
        guard let zipCode = zipCodeTextfield.text  else {
            showAlert(title: "Missing Input", message: "All Fields must be filled in")
            return
        }
        var apartment: String?
        if apartmentTextfield.text != nil && !(apartmentTextfield.text?.isEmpty)! {
            apartment = apartmentTextfield.text
        } else {
            apartment = nil
        }
        
        locationRequest = LocationRequest(borough: borough, houseNumber: houseNumber, streetName: streetName, apartment: apartment, zipCode: zipCode)
        HousingAPIClient.manager.getViolations(usingLocation: locationRequest) { (result) in
            switch result {
                
            case .success(let onlineViolations):
                self.violationsArr = onlineViolations
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "ViolationsSegue", sender: self)
            case .failure(let error):
                print(error)
                SVProgressHUD.dismiss()
                self.showAlert(title: "Error", message: "No results found, please check address")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //send array of violations to maintableviewcontroller
        if segue.destination is MainTableViewController {
            let mainTableVC = segue.destination as? MainTableViewController
            mainTableVC?.allViolations = violationsArr
            mainTableVC?.locationRequest = locationRequest
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        SVProgressHUD.show()
        search()
    }
    
    // MARK: - Keyboard handling
    
    @IBOutlet weak var formScrollView: UIScrollView!
    var activeTextfield: UITextField?
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: Notification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWasShown(_ aNotification: NSNotification) {
        guard let info = aNotification.userInfo,
            let activeTextfield = self.activeTextfield else { return }
        let kbSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: kbSize.height, right: 0)
        
        self.formScrollView.contentInset = contentInsets
        self.formScrollView.scrollIndicatorInsets = contentInsets
        
        var aRect = self.view.frame
        aRect.size.height -= kbSize.height
        if (!aRect.contains(activeTextfield.frame.origin)) {
            
            let scrollPoint = CGPoint(x: 0.0, y: activeTextfield.frame.origin.y - kbSize.height)
            self.formScrollView.setContentOffset(scrollPoint, animated: true)
        }
    }
    
    @objc func keyboardWillBeHidden(_ aNotification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.formScrollView.contentInset = contentInsets
        self.formScrollView.scrollIndicatorInsets = contentInsets
    }
    
    
    // MARK: Dismiss keyboard with tap
    
    func addDismisKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.formScrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.activeTextfield?.resignFirstResponder()
    }
}
extension SearchFormViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextfield = textField
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var fieldsFilledOut: Bool
        switch textField {
        case houseNumberTextfield:
            let allowedCharacters = CharacterSet.init(charactersIn: "1234567890-")
            let characterSet = CharacterSet(charactersIn: string)
            fieldsFilledOut = !((houseNumberTextfield.text! + string).isEmpty ||
                streetNameTextfield.text!.isEmpty ||
                zipCodeTextfield.text!.isEmpty)
            searchButton.isEnabled = fieldsFilledOut
            return allowedCharacters.isSuperset(of: characterSet)
        case streetNameTextfield:
            fieldsFilledOut = !(houseNumberTextfield.text!.isEmpty ||
                (streetNameTextfield.text! + string).isEmpty ||
                zipCodeTextfield.text!.isEmpty)
            searchButton.isEnabled = fieldsFilledOut
        case zipCodeTextfield:
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            fieldsFilledOut = !(houseNumberTextfield.text!.isEmpty ||
                streetNameTextfield.text!.isEmpty ||
                (zipCodeTextfield.text! + string).isEmpty)
            searchButton.isEnabled = fieldsFilledOut
            return allowedCharacters.isSuperset(of: characterSet) && (textField.text! + string).count <= 5
        default: return true
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case houseNumberTextfield:
            streetNameTextfield.becomeFirstResponder()
        case streetNameTextfield:
            apartmentTextfield.becomeFirstResponder()
        case apartmentTextfield:
            zipCodeTextfield.becomeFirstResponder()
        case zipCodeTextfield:
            search()
        default: return true
        }
        return true
    }
}


//// Call this method somewhere in your view controller setup code.
//- (void)registerForKeyboardNotifications
//    {
//        [[NSNotificationCenter defaultCenter] addObserver:self
//            selector:@selector(keyboardWasShown:)
//            name:UIKeyboardDidShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//            selector:@selector(keyboardWillBeHidden:)
//            name:UIKeyboardWillHideNotification object:nil];
//    }
//
//
//
//
//    // Called when the UIKeyboardDidShowNotification is sent.
//    - (void)keyboardWasShown:(NSNotification*)aNotification
//{
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    scrollView.contentInset = contentInsets;
//    scrollView.scrollIndicatorInsets = contentInsets;
//
//    // If active text field is hidden by keyboard, scroll it so it's visible
//    // Your application might not need or want this behavior.
//    CGRect aRect = self.view.frame;
//    aRect.size.height -= kbSize.height;
//    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
//        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
//        [scrollView setContentOffset:scrollPoint animated:YES];
//    }
//    }
//
//
//    // Called when the UIKeyboardWillHideNotification is sent
//    - (void)keyboardWillBeHidden:(NSNotification*)aNotification
//{
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    scrollView.contentInset = contentInsets;
//    scrollView.scrollIndicatorInsets = contentInsets;
//}
//




