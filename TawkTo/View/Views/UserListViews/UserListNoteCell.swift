//
//  UserListNoteCell.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 10/10/21.
//

import Foundation
import UIKit

class UserListNoteCell: UserListCell {
    
    //MARK: Properties
//    let identifier = UserListNoteCell.defaultReuseIdentifier

    
    //MARK: Initialization methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureWithModel(_ model: UserCellViewModel) {
        self.noteImage.isHidden = false
    }
}
