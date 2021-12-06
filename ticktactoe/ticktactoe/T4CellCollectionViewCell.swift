//
//  T4CellCollectionViewCell.swift
//  ticktactoe
//
//  Created by DCS on 04/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class T4CellCollectionViewCell: UICollectionViewCell {
    
    private let myimageview:UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.clipsToBounds = true
        return imageview
    }()
    
    func setupcell(with status:Int)
    {
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.addSubview(myimageview)
        
        myimageview.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        print(status)
        
        let name  = (status == 0) ? ("o") : (status == 1 ? "x" : "")
        
        myimageview.image = UIImage(named: name)
    }
}

