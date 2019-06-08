//
//  ViewController.swift
//  TableViewExercise
//
//  Created by Ada 2018 on 25/04/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var contatos: [(nome: String, num: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contatos = [
            (nome: "Paulo", num: "3333-3333"),
            (nome: "Pedro", num: "3344-3234"),
            (nome: "João", num: "3211-1111")
        ]
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Questão 01
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = contatos[indexPath.row].nome
        cell.detailTextLabel?.text = contatos[indexPath.row].num
        
        return cell
    }
    
    // Questão 04
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let title = self.contatos[indexPath.row].nome
        let number = self.contatos[indexPath.row].num
        
        let alert = UIAlertController(title: title, message: number, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
