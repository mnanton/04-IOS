//
//  TransformViewCell.swift
//  DBHeroes
//
//  Created by Miguel Nantón Díaz on 5/11/23.
//

import UIKit

class TransformViewCell: UITableViewCell {

    @IBOutlet weak var picPhoto: UIImageView!
    @IBOutlet weak var lblTransformacion: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
