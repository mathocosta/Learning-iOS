//
//  ViewController.swift
//  iOSCoreBluetooth
//
//  Created by Matheus Costa on 05/06/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var label: UILabel!

    // MARK: - Properties
    var manager: BluetoothManager?

    // MARK: - Lifecyle
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.manager = BluetoothManager(delegate: self)
    }

}

// MARK: - BlueEar
extension ViewController: BlueEar {

    func didStartConfiguration() { self.label.text = "Configurando.." }

    func didStartAdvertising() { self.label.text = "Disponível para conexão" }

    func didSendData() { self.label.text = "Dados enviados" }

    func didReceive(data: [String: String]) { self.label.text = "Dados recebidos: \(data)" }

}

