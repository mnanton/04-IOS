//
//  TransformViewController.swift
//  DBHeroes
//
//  Created by Miguel Nantón Díaz on 6/11/23.
//

import UIKit

class TransformViewController: UIViewController {
    var hero: Hero?
    private var transformation: Transformation?
    var transformations: [Transformation] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "cellheroes")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.tintColor = UIColor.blue
        }
    }}

// MARK - TableView DataSource
extension TransformViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Cargamos los datos a nuestra celda customizada, aprovechando la de Heroes creada anteriormente
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellheroes", for: indexPath) as? ListTableViewCell
        cell?.accessoryType = .disclosureIndicator
        
        let transform = transformations[indexPath.row]
        cell!.lblPersonaje.text = transform.name
        cell!.lblDescripcion.text = transform.description
        cell!.uiFoto.setImage(for: transform.photo)
        return cell!
    }
}

extension TransformViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        // Obtenemos datos de la celda actual, y los pasamos a la siguiente vista
        if let cell = tableView.cellForRow(at: indexPath) as? ListTableViewCell {
            let vc = TransInfoViewController()
            vc.transformation = transformations[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
