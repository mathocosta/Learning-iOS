//
//  FirstViewController.swift
//  LearnFirebase
//
//  Created by Matheus Oliveira Costa on 15/08/19.
//  Copyright © 2019 Matheus Oliveira Costa. All rights reserved.
//

import UIKit
import Firebase

typealias UserData = [String: Any]

protocol UserAuthenticationDelegate: class {
    func didAuthenticate(user: UserData)
}

class FirstViewController: UIViewController {

    enum Segues: String {
        case showSignUp = "ShowSignUp"
        case showLogin = "ShowLogin"
        case showHome = "ShowHome"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.showHome.rawValue {
            guard let user = sender as? UserData,
                let homeViewController = segue.destination as? HomeViewController else { return }

            homeViewController.welcomeLabelText = "Welcome \(String(describing: user["firstName"]!))"
        } else if segue.identifier == Segues.showSignUp.rawValue {
            guard let vc = segue.destination as? SignUpViewController else { return }
            vc.delegate = self
        } else if segue.identifier == Segues.showLogin.rawValue {
            guard let vc = segue.destination as? LoginViewController else { return }
            vc.delegate = self
        }
    }

    @IBAction func signUpTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: Segues.showSignUp.rawValue, sender: nil)
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: Segues.showLogin.rawValue, sender: nil)
    }

}

// MARK: - UserAuthenticationDelegate
extension FirstViewController: UserAuthenticationDelegate {

    func didAuthenticate(user: UserData) {
        self.performSegue(withIdentifier: Segues.showHome.rawValue, sender: user)
    }

}
