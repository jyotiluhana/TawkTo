//
//  SkeletonUserCell.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 17/10/21.
//

import UIKit

class SkeletonUserCell: UserListCell {

    //MARK: Properties
    private var shimmerLoader: ShimmerLoader?
    
    //MARK: Initialization methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        updateSkeletonCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateSkeletonCell() {
        self.detailStackView.spacing = 8
        self.userProfileImage.addShimmerLoading()
        self.titleLabel.addShimmerLoading()
        self.detailLabel.addShimmerLoading()
        self.noteImage.isHidden = true
    }
    
    override func configureWithModel(_ model: UserCellViewModel) {
        
    }

}
