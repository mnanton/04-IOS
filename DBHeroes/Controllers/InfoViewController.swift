//
//  InfoViewController.swift
//  DBHeroes
//
//  Created by Miguel Nantón Díaz on 1/10/23.
//

import UIKit


class InfoViewController: UIViewController {
    var hero: Hero?
        
    @IBOutlet weak var titleNavigation: UINavigationBar!
    @IBOutlet weak var uiFoto: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblDescripcion: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = hero?.name
        lblNombre.text = hero?.name
        lblDescripcion.text = hero?.description
        uiFoto.setImage(for: hero!.photo)
    }
}
