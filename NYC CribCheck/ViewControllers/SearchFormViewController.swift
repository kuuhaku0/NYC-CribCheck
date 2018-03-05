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

class SearchFormViewController: UIViewController {
    //TODO: get borough from borough select view
    var borough = ""
    var violationsArr = [Violation]()
    
    @IBOutlet weak var houseNumberTextfield: MDCTextField!
    @IBOutlet weak var streetNameTextfield: MDCTextField!
    @IBOutlet weak var apartmentTextfield: MDCTextField!
    @IBOutlet weak var zipCodeTextfield: MDCTextField!
    
    var hnTFController: MDCTextInputControllerLegacyDefault!
    var snTFController: MDCTextInputControllerLegacyDefault!
    var aptTFController: MDCTextInputControllerLegacyDefault!
    var zcTFController: MDCTextInputControllerLegacyDefault!
    //    @IBOutlet weak var houseNumberLabel: UILabel!
    //    @IBOutlet weak var streetNameLabel: UILabel!
    //    @IBOutlet weak var apartmentLabel: UILabel!
    //    @IBOutlet weak var zipCodeLabel: UILabel!
    
    
    @IBOutlet weak var searchButton:MDCRaisedButton!
    
    public static func storyboardInstance() -> SearchFormViewController {
        let storyboard = UIStoryboard(name: "SearchForm", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchFormViewController") as! SearchFormViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        hnTFController.errorColor = UIColor.lightGray
        snTFController.errorColor = UIColor.lightGray
        aptTFController.errorColor = UIColor.lightGray
        zcTFController.errorColor = UIColor.lightGray
        hnTFController.setErrorText("i.e. 1234", errorAccessibilityValue: nil)
        snTFController.setErrorText("i.e. East 48 Street", errorAccessibilityValue: nil)
        aptTFController.setErrorText("*optional i.e. 2R ", errorAccessibilityValue: nil)
        zcTFController.setErrorText("i.e. 12345", errorAccessibilityValue: nil)
        
        hnTFController.isFloatingEnabled = true
        snTFController.isFloatingEnabled = true
        aptTFController.isFloatingEnabled = true
        zcTFController.isFloatingEnabled = true
        
        searchButton.isEnabled = false
//        searchButton.setElevation(.none, for: .normal)
//        searchButton.setBackgroundColor(<#T##backgroundColor: UIColor?##UIColor?#>)
//        searchButton.setTitleColor(<#T##color: UIColor?##UIColor?#>, for: <#T##UIControlState#>)
//        searchButton
        houseNumberTextfield.autocorrectionType = .no
        houseNumberTextfield.autocapitalizationType = .none
        streetNameTextfield.autocorrectionType = .no
        streetNameTextfield.autocapitalizationType = .none
        apartmentTextfield.autocorrectionType = .no
        apartmentTextfield.autocapitalizationType = .none
        zipCodeTextfield.autocorrectionType = .no
        zipCodeTextfield.autocapitalizationType = .none
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
//        var apartment = apartmentTextfield.text?.uppercased()
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
        //TODO: api call with the above params, completion handler contains perform segue
        //completion should populate violationsArr
        //violationsArr = [Violation]()
        //switch on result if failure error
        //        switch result {
        //        case .success(let success):
        // returns [violations]
        //        case let .failure(let failure):
        //        returns an error
        
        
        HousingAPIClient.manager.getViolations(usingLocation: locationRequest) { (result) in
            switch result {
                
            case .success(let onlineViolations):
                //                PersistanceService.manager.addToPreviousSearches(search: location)
                self.violationsArr = onlineViolations
                self.performSegue(withIdentifier: "ViolationsSegue", sender: self)
            case .failure(let error):
                print(error)
                self.showAlert(title: "Error", message: "No results found, please check address")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //send array of violations to maintableviewcontroller
        if segue.destination is MainTableViewController {
            let mainTableVC = segue.destination as? MainTableViewController
            mainTableVC?.violationsArr = violationsArr
            mainTableVC?.locationRequest = locationRequest
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        search()
    }
    
}
extension SearchFormViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var fieldsFilledOut: Bool
//        let fieldsFilledOut = !(houseNumberTextfield.text!.isEmpty ||
//                                streetNameTextfield.text!.isEmpty ||
//                                 zipCodeTextfield.text!.isEmpty)
//        searchButton.isEnabled = fieldsFilledOut
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


