//
//  TransInfoViewController.swift
//  DBHeroes
//
//  Created by Miguel Nantón Díaz on 6/11/23.
//

import UIKit

class TransInfoViewController: UIViewController {
    var hero: Hero?
    var transformation: Transformation?

    @IBOutlet weak var lblTransformacion: UILabel!
    @IBOutlet weak var txtDescripcion: UITextView!
    @IBOutlet weak var uiFoto: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTransformacion.text = transformation?.name
        txtDescripcion.text = transformation?.description
        uiFoto.setImage(for: transformation!.photo)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)

           if let navigationController = self.navigationController {
               navigationController.navigationBar.tintColor = UIColor.white
           }
    }}
