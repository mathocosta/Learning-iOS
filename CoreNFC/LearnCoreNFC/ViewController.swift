//
//  ViewController.swift
//  LearnCoreNFC
//
//  Created by Matheus Costa on 16/04/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController {
    var readerSession: NFCNDEFReaderSession!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onStartScanning(_ sender: UIButton) {
        self.readerSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        self.readerSession.alertMessage = "Hold your iPhone near the item to learn more about it."
        self.readerSession.begin()
    }

}

// MARK: - NFCNDEFReaderSessionDelegate implementation
extension ViewController: NFCNDEFReaderSessionDelegate {

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        if let readerError = error as? NFCReaderError {
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead) &&
                (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                let alertController = UIAlertController(title: "Session Invalidated",
                                                        message: readerError.localizedDescription,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print(messages)
    }

}
