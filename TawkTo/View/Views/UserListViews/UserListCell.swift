//
//  UserListCell.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 09/10/21.
//

import UIKit

class UserListCell: Reusable, Configurable  {
    
    //MARK: Properties
    var model: UserCellViewModel?
    
    //MARK: Controls
    lazy var mainStackView : UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [userProfileImage, detailStackView, noteImage])
        stackview.axis = .horizontal
        stackview.distribution = .fillProportionally
        stackview.spacing = 8
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var userProfileImage : UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "square.and.arrow.up.circle")
        imageview.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = true
        return imageview
    }()
    
    lazy var detailStackView : UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "title"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var detailLabel : UILabel = {
        let label = UILabel()
        label.text = "detail"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var noteImage : UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "note")
        imageview.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = true
        return imageview
    }()
    
    //MARK: Initialization methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.userProfileImage.cornerRadius = self.userProfileImage.frame.height / 2
    }
    
    //MARK: View setup
    private func setupViews() {
        self.contentView.addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        self.mainStackView.fillToSuperview(with: 8)
        NSLayoutConstraint.activate([
//            self.userProfileImage.widthAnchor.constraint(equalTo: self.userProfileImage.heightAnchor, multiplier: 1),
            self.userProfileImage.widthAnchor.constraint(equalToConstant: 54),
            self.userProfileImage.heightAnchor.constraint(equalToConstant: 54),
            self.noteImage.widthAnchor.constraint(equalTo: self.userProfileImage.heightAnchor, multiplier: 1/2.5)
        ])
    }
    
    func configureWithModel(_ model: UserCellViewModel) {
        self.noteImage.isHidden = true
        self.model = model
        self.titleLabel.text = model.username
        self.detailLabel.text = model.url
        self.userProfileImage.url(model.avatar_url)
    }
}
