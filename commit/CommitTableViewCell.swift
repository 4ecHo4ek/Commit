//
//  CommitTableViewCell.swift
//  commit
//
//  Created by Сергей Цыганков on 11.05.2020.
//  Copyright © 2020 Сергей Цыганков. All rights reserved.
//

import UIKit

class CommitTableViewCell: UITableViewCell {

    @IBOutlet weak var commitImage: UIImageView!
    @IBOutlet weak var commitName: UILabel!
    @IBOutlet weak var commitDescription: UILabel!
    @IBOutlet weak var commitMark: UILabel!
    
    
    func set(commit: Commits) {
        self.commitName.text = commit.name
        self.commitDescription.text = commit.description
        self.commitMark.text = String(commit.mark)
        self.commitImage.image = UIImage(systemName: commit.image)
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
