//
//  ViewController1.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    //TODO: get borough from borough select view
    var borough = ""
    var violationsArr = [Violation]()
    
    @IBOutlet weak var houseNumberTextfield: UITextField!
    @IBOutlet weak var streetNameTextfield: UITextField!
    @IBOutlet weak var apartmentTextfield: UITextField!
    @IBOutlet weak var zipCodeTextfield: UITextField!
    
  
    //    @IBOutlet weak var houseNumberLabel: UILabel!
    //    @IBOutlet weak var streetNameLabel: UILabel!
    //    @IBOutlet weak var apartmentLabel: UILabel!
    //    @IBOutlet weak var zipCodeLabel: UILabel!

    
    @IBOutlet weak var searchButton:UIButton!
    
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
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func search() {
        var apartment = apartmentTextfield.text?.uppercased()
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
        if apartmentTextfield.text != nil {
            let apartment = apartmentTextfield.text
        } else {
            apartment = nil
    }
    
    let location = LocationRequest(borough: borough, houseNumber: houseNumber, streetName: streetName, apartment: apartment, zipCode: zipCode)
    //TODO: api call with the above params, completion handler contains perform segue
    //completion should populate violationsArr
    //violationsArr = [Violation]()
    //switch on result if failure error
    //        switch result {
    //        case .success(let success):
    // returns [violations]
    //        case let .failure(let failure):
    //        returns an error
    
    
    HousingAPIClient.manager.getViolations(usingLocation: location) { (result) in
    switch result {
    
    case .success(let onlineViolations):
    self.violationsArr = onlineViolations
    self.performSegue(withIdentifier: "ViolationsSegue", sender: self)
    case .failure(_):
    self.showAlert(title: "Error", message: "No results found, please check address")
    }
    }
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //send array of violations to maintableviewcontroller
    if segue.destination is MainTableViewController {
        let mainTableVC = segue.destination as? MainTableViewController
        mainTableVC?.violationsArr = violationsArr
    }
}

@IBAction func submitButtonPressed(_ sender: Any) {
    search()
}

}
extension FormViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == 1 {
            //Numbers only handling for house textfield
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        if textField.tag == 4 {
            //Numbers only handling for postCode textfield
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        return true
    }
}

