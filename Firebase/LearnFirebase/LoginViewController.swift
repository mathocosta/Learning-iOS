//
//  LoginViewController.swift
//  LearnFirebase
//
//  Created by Matheus Oliveira Costa on 15/08/19.
//  Copyright © 2019 Matheus Oliveira Costa. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    weak var delegate: UserAuthenticationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        guard let emailText = self.emailTextField.text, !emailText.isEmpty else { return }
        guard let passwordText = self.passwordTextField.text, !passwordText.isEmpty else { return }


        Auth.auth().signIn(withEmail: emailText, password: passwordText) { [weak self] (authResult, error) in
            guard let authResult = authResult, error == nil else {
                self?.errorLabel.alpha = 1
                self?.errorLabel.text = error?.localizedDescription
                return
            }

            let db = Firestore.firestore()
            let usersRef = db.collection("users")
            let query = usersRef.whereField("uid", isEqualTo: authResult.user.uid)

            query.getDocuments(completion: { (querySnapshot, error) in
                guard let document = querySnapshot?.documents.first, error == nil else { return }
                self?.dismiss(animated: true) {
                      self?.delegate?.didAuthenticate(user: document.data())
                }
            })

        }
    }
    
}
