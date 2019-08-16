//
//  SignUpViewController.swift
//  LearnFirebase
//
//  Created by Matheus Oliveira Costa on 15/08/19.
//  Copyright © 2019 Matheus Oliveira Costa. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    weak var delegate: UserAuthenticationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signUpTapped(_ sender: UIButton) {
        guard let emailText = self.emailTextField.text, !emailText.isEmpty else { return }
        guard let passwordText = self.passwordTextField.text, !passwordText.isEmpty else { return }
        guard let firstNameText = self.firstNameTextField.text else { return }
        guard let lastNameText = self.lastNameTextField.text else { return }

        Auth.auth().createUser(withEmail: emailText, password: passwordText) { [weak self] (authResult, error) in
            guard let authResult = authResult, error == nil else {
                self?.errorLabel.alpha = 1
                self?.errorLabel.text = error?.localizedDescription
                return
            }

            let db = Firestore.firestore()
            let newDocument = db.collection("users").document()
            let documentData = [
                "firstName": firstNameText,
                "lastName": lastNameText,
                "uid": authResult.user.uid
            ]
            newDocument.setData(documentData) { [weak self] (error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }

                self?.didCreate(user: newDocument)
            }
            
        }
    }

    func didCreate(user: DocumentReference) {
        user.getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                self?.dismiss(animated: true, completion: {
                    self?.delegate?.didAuthenticate(user: document.data()!)
                })
            }
        }
    }

}
