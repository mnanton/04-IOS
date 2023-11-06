//
//  ListTableViewCell.swift
//  DBHeroes
//
//  Created by Miguel Nantón Díaz on 1/10/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet weak var uiFoto: UIImageView!
    @IBOutlet weak var lblPersonaje: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
