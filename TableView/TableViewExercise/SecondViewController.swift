//
//  SecondViewController.swift
//  TableViewExercise
//
//  Created by Ada 2018 on 25/04/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customTableCell: CustomTableViewCell!
    
    var conteudo: [(nome: String, imagem: UIImage)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conteudo = [
            (nome: "Beira Mar", imagem: #imageLiteral(resourceName: "beira_bar")),
            (nome: "Mercado dos Peixes", imagem: #imageLiteral(resourceName: "mercado_dos_peixes")),
            (nome: "Morro Branco", imagem: #imageLiteral(resourceName: "morro_branco")),
            (nome: "Canoa Quebrada", imagem: #imageLiteral(resourceName: "canoa_quebrada")),
            (nome: "Pedra Furada", imagem: #imageLiteral(resourceName: "pedra_furada"))
        ]
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conteudo.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        customCell.backgroundImage.image = conteudo[indexPath.row].imagem
        customCell.nameLabel.text = conteudo[indexPath.row].nome
        
        return customCell
    }
    
    
}
