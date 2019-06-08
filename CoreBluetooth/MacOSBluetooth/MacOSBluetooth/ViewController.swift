//
//  ViewController.swift
//  MacOSBluetooth
//
//  Created by Matheus Costa on 05/06/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var button: NSButton!
    @IBOutlet weak var field: NSTextField!

    // MARK: - Properties
    var manager: BluetoothManager?

    // MARK: - Lifecyle
    @IBAction func discover(_ sender: Any) {

        self.manager = BluetoothManager(delegate: self)
        self.manager?.scan()

    }

    @IBAction func onSendButtonPressed(_ sender: NSButton) {
        let text = self.field.stringValue
        self.manager?.send(message: text)
    }

}

// MARK: - BlueEar
extension ViewController: BlueEar {

    func didStartConfiguration() { self.label.stringValue = "Iniciando configuração" }

    func didStartScanningPeripherals() { self.label.stringValue = "Escaneando por periféricos" }

    func didConnectPeripheral(name: String?) { self.label.stringValue = "Conectado ao: \(name ?? "")" }

    func didDisconnectPeripheral(name: String?) { self.label.stringValue = "Desconectado: \(name ?? "")" }

    func didSendData() { self.label.stringValue = "Dados enviados" }

    func didReceiveData() { self.label.stringValue = "Dados recebidos" }

    func didFailConnection() { self.label.stringValue = "Conexão falhou" }

}
