//
//  PostTableViewCell.swift
//  NetworkDemo
//
//  Created by gongruike on 16/5/14.
//  Copyright © 2016年 gongruike. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        detailTextLabel?.text = post.text
        
        if post.text.characters.count > 10 {
        }
    }

}
