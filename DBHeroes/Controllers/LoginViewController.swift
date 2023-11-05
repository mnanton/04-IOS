//
//  LoginViewController.swift
//  DBHeroes
//
//  Created by Miguel Nantón Díaz on 26/9/23.
//

import UIKit

class LoginViewController: UIViewController {

// Mark - Action
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblWarning: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        lblWarning.isHidden = true
    }
    
    @IBAction func validarLogin(_ sender: Any) {
        self.lblWarning.isHidden = true
        
// MARK - Verificamos los datos de acceso del usuario
        let model = NetworkModel()
        model.login(user: txtUsername.text ?? "", password: txtPassword.text ?? "") {[weak self] result in
            switch result {
            case let .success(token):
                
                DispatchQueue.main.async {
                    let vc = ListTableViewController()
                    self?.navigationController?.setViewControllers( [vc], animated: true)
                }
                
            case let .failure(error):
                
// Indicamos mediante mensaje en un Label, el tipo de error.
                if case .statusCode(let statusCode) = error, statusCode == 401 {
                    DispatchQueue.main.async {
                        self?.lblWarning.isHidden = false
                        self?.lblWarning.text = "Error de credenciales"
                    }
               }
                
                if case .statusCode(let statusCode) = error, statusCode == 403 {
                    DispatchQueue.main.async {
                        self?.lblWarning.isHidden = false
                        self?.lblWarning.text = "Fallo conexión con Servidor"
                    }
                }
            }
        }
    }
}
