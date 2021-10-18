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
//    var network : NetworkListner?
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
//        self.userDetailsViewModel.fetchUserDetailsFromDB(withId: userCellViewModel!.id)
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
//        network = NetworkListner(delegate: self)
        self.setupView()
    }
    
    @IBAction func didTapSave(_ sender: UIButton) {
        if let note = txtViewNotes.text {
            self.userDetailsViewModel.addUserNotes(note: note)
//            self.showAppAlert(title: "Alert", message: "Note saved to Database!", style: .alert, actions: [], completion: nil)
            self.showAppAlertWithOK(message: "Note saved to Database!", buttonAction: nil, style: .alert, buttonStyle: .default, completion: nil)
        }
    }
}

extension UserDetailsController {
    func setupInitialData() {
        self.lblFollowers.text = userCellViewModel?.followers
        self.lblFollowing.text = userCellViewModel?.following
        
        self.lblName.text = "\(NetworkListner.shared.isNetworkAvailable)" //userCellViewModel?.name
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
