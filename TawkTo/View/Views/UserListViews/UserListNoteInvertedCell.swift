//
//  UserListNoteInvertedCell.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 10/10/21.
//

import Foundation
import UIKit

class UserListNoteInvertedCell: UserListCell {
    
    //MARK: Properties
    
    //MARK: Initialization methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureWithModel(_ model: UserCellViewModel) {
        self.contentView.backgroundColor = model.is_visited ? .lightGray : .systemBackground
        self.noteImage.isHidden = false
        self.titleLabel.text = model.username
        self.detailLabel.text = model.url
        self.userProfileImage.url(model.avatar_url, setInverted: true)
    }
}
