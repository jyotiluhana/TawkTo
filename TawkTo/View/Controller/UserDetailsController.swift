//
//  UserDetailsController.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 11/10/21.
//

import UIKit

class UserDetailsController: UIViewController {
    
    //MARK: - Properties
    var userCellViewModel : UserCellViewModel?
    var userDetailsViewModel = UserDetailsViewModel()
    
    //MARK: Controls 
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblFollowing: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblBlog: UILabel!
    @IBOutlet weak var txtViewNotes: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.userDetailsViewModel.delegate = self
        if let username = userCellViewModel?.username {
            self.userDetailsViewModel.fetchUserDetails(withUsername: username)
        }
    }
    
    
    @IBAction func didTapSave(_ sender: UIButton) {
        
    }
}

extension UserDetailsController {
    func setupInitialData() {
        self.lblFollowers.text = userCellViewModel?.followers
        self.lblFollowing.text = userCellViewModel?.following
        
        self.lblName.text = userCellViewModel?.name
        self.lblCompany.text = userCellViewModel?.company
        self.lblBlog.text = userCellViewModel?.blog
        
        self.txtViewNotes.text = userCellViewModel?.note
    }
}

extension UserDetailsController: UserDetailsDataProvider {
    func didFetchUserDetails() {
        self.userCellViewModel = userDetailsViewModel.getUserDetails()
        DispatchQueue.main.async {
            self.setupInitialData()
        }
    }
}
