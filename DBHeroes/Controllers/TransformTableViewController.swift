//
//  TransformTableViewController.swift
//  DBHeroes
//
//  Created by Miguel Nantón Díaz on 5/11/23.
//

import UIKit

class TransformTableViewController: UITableViewController {
       
    var hero: Hero?
    private var transformation: Transformation?
    var transformations: [Transformation] = []
    
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
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cargamos los datos a nuestra celda customizada
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellheroes", for: indexPath) as? ListTableViewCell
        cell?.accessoryType = .disclosureIndicator
        
        //Reutilizo la celda, cambiando el nombre del personaje por la descripción de la transformación
        let transform = transformations[indexPath.row]
        cell!.lblPersonaje.text = transform.name
        cell!.lblDescripcion.text = transform.description
        cell!.uiFoto.setImage(for: transform.photo)
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        // Obtenemos datos de la celda actual, y los pasamos a la siguiente vista
        if let cell = tableView.cellForRow(at: indexPath) as? ListTableViewCell {
            //let vc = InfoViewController()
            //vc.hero = listHeroes[indexPath.row]
            //self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
