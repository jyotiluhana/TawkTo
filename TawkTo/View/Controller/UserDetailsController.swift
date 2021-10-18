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
    var shimmerLoader = [UIView : UIView.ShimmerLoader]()
    lazy var shimmerViews = [userProfileImage, followerStackView, userDetailsView, lblNotes, txtViewNotes, btnSave]
    
    //MARK: Controls 
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblFollowing: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblBlog: UILabel!
    @IBOutlet weak var txtViewNotes: UITextView!
    
    @IBOutlet weak var followerStackView: UIStackView!
    @IBOutlet weak var userDetailsView: UIView!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.userDetailsViewModel.delegate = self
        if let username = userCellViewModel?.username {
            if NetworkListner.shared.isNetworkAvailable {
                self.userDetailsViewModel.fetchUserDetails(withUsername: username)
            } else {
                self.userDetailsViewModel.fetchUserDetailsFromDB(withId: userCellViewModel!.id)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkListner.shared.delegate = self
        self.setupView()
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
        self.userProfileImage.url(userCellViewModel?.avatar_url)
    }
    
    func setupView() {
        for views in shimmerViews {
            if let vw = views {
                vw.borderWidth = 0
                shimmerLoader[vw] = vw.addShimmerLoading()
            }
        }
    }
    
    func removeView() {
        self.userDetailsView.borderWidth = 1
        self.txtViewNotes.borderWidth = 1
        self.btnSave.borderWidth = 1
        for (key,value) in shimmerLoader {
            key.removeShimmer(loader: value)
        }
    }
}

extension UserDetailsController: UserDetailsDataProvider {
    func didFetchUserDetails() {
        self.userCellViewModel = userDetailsViewModel.getUserDetails()
        if let data = self.userDetailsViewModel.fetchUserNoteForId(userCellViewModel!.id) {
            self.userCellViewModel?.notes = data
        }
        DispatchQueue.main.async {
            self.removeView()
            self.setupInitialData()
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//            self.removeView()
//            self.setupInitialData()
//        }
    }

    func didUpdateNote() {
        self.txtViewNotes.text = userCellViewModel?.note
    }
}

extension UserDetailsController: NetworkUpdates {
    func networkDidBecameActive() {
        debugPrint("Online details:")
        if let username = userCellViewModel?.username {
            self.userDetailsViewModel.fetchUserDetails(withUsername: username)
        }
    }
    
    func networkDidBecameDeactive() {
        debugPrint("Offline details:")
        if let id = userCellViewModel?.id {
            self.userDetailsViewModel.fetchUserDetailsFromDB(withId: id)
        }
    }
    
    
}
