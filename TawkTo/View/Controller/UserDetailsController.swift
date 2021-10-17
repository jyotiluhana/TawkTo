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
//        self.setupView()
    }
    
    @IBAction func didTapSave(_ sender: UIButton) {
        if let note = txtViewNotes.text {
            self.userDetailsViewModel.addUserNotes(note: note)
        }
    }
}

extension UserDetailsController {
    func setupInitialData() {
        self.lblFollowers.text = userCellViewModel?.followers
        self.lblFollowing.text = userCellViewModel?.following
        
        self.lblName.text = userCellViewModel?.name
        self.lblCompany.text = userCellViewModel?.company
        self.lblBlog.text = userCellViewModel?.blog
        
        self.txtViewNotes.text = userCellViewModel?.notes?.note
    }
    
    func setupView() {
        self.userProfileImage.addShimmerLoading()
        self.lblFollowers.addShimmerLoading()
        self.lblFollowing.addShimmerLoading()
        self.lblName.addShimmerLoading()
        self.lblCompany.addShimmerLoading()
        self.lblBlog.addShimmerLoading()
        self.txtViewNotes.addShimmerLoading()
    }
}

extension UserDetailsController: UserDetailsDataProvider {
    func didFetchUserDetails() {
        self.userCellViewModel = userDetailsViewModel.getUserDetails()
        if let data = self.userDetailsViewModel.fetchUserNoteForId(userCellViewModel!.id) {
            self.userCellViewModel?.notes = data
        }
        DispatchQueue.main.async {
            self.setupInitialData()
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
//            self.setupInitialData()
//        }
    }

    func didUpdateNote() {
        self.txtViewNotes.text = userCellViewModel?.note
    }
}
