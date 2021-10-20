//
//  NoDataView.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 19/10/21.
//

import Foundation
import UIKit

extension UITableView {
    func showNoDataIndicator() {
        
        lazy var noDataImageView : UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.image = UIImage(named: "no_data")
            return iv
        }()
        
        lazy var titleLabel : UILabel = {
            let lbl = UILabel()
            lbl.text = "NO DATA FOUND!"
            lbl.textAlignment = .center
            lbl.font = UIFont.systemFont(ofSize: 20)
            return lbl
        }()
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyView.addSubview(noDataImageView)
        emptyView.addSubview(titleLabel)
        
        noDataImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        noDataImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        noDataImageView.anchorCenterXToSuperview()
        noDataImageView.anchorCenterYToSuperview()
        
        titleLabel.anchor(noDataImageView.bottomAnchor, left: emptyView.leftAnchor, bottom: nil, right: emptyView.rightAnchor, topConstant: 40, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        
        self.backgroundView = emptyView
        self.separatorStyle = .none

    }
    
    func removeNoDataIndicator() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
