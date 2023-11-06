//
//  InfoViewController.swift
//  DBHeroes
//
//  Created by Miguel Nantón Díaz on 1/10/23.
//

import UIKit

class InfoViewController: UIViewController {
    var hero: Hero?
    private var transformation: Transformation?
    private var transformations: [Transformation] = []
        
    @IBOutlet weak var titleNavigation: UINavigationBar!
    @IBOutlet weak var uiFoto: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblDescripcion: UITextView!
    @IBOutlet weak var onTapped: UIButton!
    
    @IBAction func onTappedbutton(_ sender: Any) {
       
        if let navigationController = self.navigationController {
            let vc = TransformViewController()
            vc.hero = hero
            vc.transformations = transformations
            navigationController.pushViewController(vc, animated: true)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblNombre.text = hero?.name
        lblDescripcion.text = hero?.description
        uiFoto.setImage(for: hero!.photo)
        
        transformAvailable(for: hero!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Cambiamos el mensaje del navegador a blanco, para que destaque sobre la foto
        if let navigationController = self.navigationController {
            navigationController.navigationBar.tintColor = UIColor.white
        }
    }
    
    // Con esta función averiguamos si el Heroe tiene transformacionens y ocultamos el botón si no tiene
    func transformAvailable(for hero: Hero) {
        guard let token = LocalDataModel.getToken() else { return}
        
        let model = NetworkModel()
        model.getTransformation(for: hero) { [weak self] result in
            switch result {
            case .success(let transformations):
                let sortedTransformations = transformations.sorted { $0.name < $1.name }
                self?.transformations = sortedTransformations
                if transformations.isEmpty {
                    DispatchQueue.main.async {
                        self?.onTapped.isHidden = true
                    }
                }
            case .failure(let error):
                print("Error al obtener las transformaciones: \(error)")
            }
        }
    }
}
