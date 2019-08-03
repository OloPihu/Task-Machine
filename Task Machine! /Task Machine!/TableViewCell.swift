//
//  TableViewCell.swift
//  Task Machine!
//
//  Created by Aleksander  on 03/08/2019.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var checkedBox: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

  
    }

}
