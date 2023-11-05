//
//  ListTableViewController.swift
//  DBHeroes
//
//  Created by Miguel Nantón Díaz on 1/10/23.
//

import UIKit

class ListTableViewController: UIViewController {

    let model = NetworkModel()
    var listHeroes: [Hero] = []
    private var idHero: String = ""
    private var urlPhoto: URL?
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     // MARK - Solicitamos listado de Heroes a la API
        model.getHeroes { [weak self] result in
            switch result {
            case .success(let heroes):
                // Cargamos los datos a un Array de nuestra clase
                self?.listHeroes = heroes
                // Actualizamos el TableView, con los datos del Array
                            DispatchQueue.main.async {
                                self?.tableView.reloadData()
                            }
            
            case .failure(let error):
                print("Error al obtener héroes: \(error)")
            }
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "cellheroes")
    }
}

// MARK - TableView DataSource
extension ListTableViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cargamos los datos a nuestra celda customizada
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellheroes", for: indexPath) as? ListTableViewCell
        cell?.accessoryType = .disclosureIndicator
        
        let hero = listHeroes[indexPath.row]
        cell!.lblPersonaje.text = hero.name
        cell!.lblDescripcion.text = hero.description
        cell!.uiFoto.setImage(for: hero.photo)
        return cell!
    }
}

extension ListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        // Obtenemos datos de la celda actual, y los pasamos a la siguiente vista
        if let cell = tableView.cellForRow(at: indexPath) as? ListTableViewCell {
            let vc = InfoViewController()
            vc.hero = listHeroes[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
