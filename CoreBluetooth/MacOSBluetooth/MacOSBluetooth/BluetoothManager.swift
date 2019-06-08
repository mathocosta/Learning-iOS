//
//  BluetoothManager.swift
//  MacOSBluetooth
//
//  Created by Matheus Costa on 05/06/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol BlueEar {

    func didStartConfiguration()

    func didStartScanningPeripherals()

    func didConnectPeripheral(name: String?)
    func didDisconnectPeripheral(name: String?)

    func didSendData()
    func didReceiveData()

    func didFailConnection()

}

class BluetoothManager: NSObject {

    // MARK: - Properties
    let serviceUUID: String = "0cdbe648-eed0-11e6-bc64-92361f002671"
    let characteristicUUID: String = "199ab74c-eed0-11e6-bc64-92361f002672"

    var serviceCBUUID: CBUUID?
    var characteristicCBUUID: CBUUID?

    var blueEar: BlueEar?

    var centralManager: CBCentralManager?

    var discoveredPeripheral: CBPeripheral?

    var message: String?

    // MARK: - Initializers
    convenience init (delegate: BlueEar) {

        self.init()

        self.blueEar = delegate

        guard let serviceUUID = NSUUID(uuidString: self.serviceUUID) as UUID?,
            let characteristicUUID: UUID = NSUUID(uuidString: self.characteristicUUID) as UUID? else { return }

        self.serviceCBUUID = CBUUID(nsuuid: serviceUUID)
        self.characteristicCBUUID = CBUUID(nsuuid: characteristicUUID)

    }

    // MARK: - Functions
    func scan() {
        self.centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
        self.blueEar?.didStartConfiguration()
    }

    func send(message: String) {
        self.message = message

        guard let discoveredPeripheral = self.discoveredPeripheral else { return }
        self.centralManager?.connect(discoveredPeripheral, options: nil)
    }
}

// MARK: - CBCentralManagerDelegate
extension BluetoothManager: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {

        print("\ncentralManagerDidUpdateState \(Date())")

        if central.state == .poweredOn {

            guard let serviceCBUUID = self.serviceCBUUID else { return }

            self.blueEar?.didStartScanningPeripherals()
            self.centralManager?.scanForPeripherals(withServices: [serviceCBUUID], options: nil)

        }

    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // We must keep a reference to the new discovered peripheral, which means we must retain it.
        self.discoveredPeripheral = peripheral

        print("\ndidDiscover:", self.discoveredPeripheral?.name ?? "")

        self.discoveredPeripheral?.delegate = self

//        guard let discoveredPeripheral: CBPeripheral = self.discoveredPeripheral else { return }
//        self.centralManager?.connect(discoveredPeripheral, options: nil)
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        let peripheralName = peripheral.name ?? ""
        print("\ndidConnect", peripheralName)
        self.blueEar?.didConnectPeripheral(name: peripheralName)

        guard let serviceCBUUID = self.serviceCBUUID else { return }

        self.discoveredPeripheral?.discoverServices([serviceCBUUID])
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        if let error = error {
            print("\ndidFailToConnect")
            print(error.localizedDescription)
        }
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        let peripheralName = peripheral.name ?? ""
        print("\ndidDisconnectPeripheral", peripheralName)
        self.blueEar?.didDisconnectPeripheral(name: peripheralName)
    }

}

// MARK: - CBPeripheralDelegate
extension BluetoothManager: CBPeripheralDelegate {

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("\ndidDiscoverServices")

        if let service = self.discoveredPeripheral?.services?.first(where: { $0.uuid == self.serviceCBUUID }) {
            guard let characteristicCBUUID = self.characteristicCBUUID else { return }

            self.discoveredPeripheral?.discoverCharacteristics([characteristicCBUUID], for: service)
        }

    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {

        print("\ndidDiscoverCharacteristicsFor")

        if let characteristic = service.characteristics?.first(where: { $0.uuid == self.characteristicCBUUID }) {
            print("Matching characteristic")
            // To listen and read dynamic values
            self.discoveredPeripheral?.setNotifyValue(true, for: characteristic)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("\ndidUpdateValueFor")

        if let value = characteristic.value {

            do {

                let receivedData = try PropertyListSerialization.propertyList(from: value, options: [], format: nil) as! [String: String]

                print("Value read is: \(receivedData)")
                self.blueEar?.didReceiveData()

            } catch let error {
                print(error)
            }

        }
        
        if let message = self.message {
            do {
                print("\nWriting on peripheral.")
                let dict = ["Message": message]
                let data = try PropertyListSerialization.data(fromPropertyList: dict, format: .binary, options: 0)

                self.discoveredPeripheral?.writeValue(data, for: characteristic, type: .withResponse)
                self.blueEar?.didSendData()
            } catch let error {
                print(error)
            }
        }


    }

    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("\ndidWriteValueFor \(Date())")
        self.centralManager?.cancelPeripheralConnection(peripheral)
        self.centralManager?.stopScan()
    }

}
