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
    
    //MARK: - View load methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupView()
        self.userDetailsViewModel.delegate = self
        
        if let username = userCellViewModel?.username {
            self.title = username
            if NetworkListner.shared.isNetworkAvailable {
                self.userDetailsViewModel.fetchUserDetails(withUsername: username)
            } else {
                self.userDetailsViewModel.fetchUserDetailsFromDB(withId: userCellViewModel!.id)
            }
        }
    }
    
    //MARK: - Button click events
    @IBAction func didTapSave(_ sender: UIButton) {
        if let note = txtViewNotes.text {
            self.userDetailsViewModel.addUserNotes(note: note)
            self.showAppAlertWithOK(message: "Note saved to Database!", buttonAction: nil, style: .alert, completion: nil)
        }
    }
}

//MARK: - Other required methods for initialization
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

//MARK: - Extension for UserDetailsDataProvider
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
    }
    
    func didGetErrorInFetchingData(error: HTTPNetworkError) {
        if let message = error.reason {
            self.showAppAlertWithOK(message: message, buttonAction: nil, style: .alert, completion: nil)
        }
    }

    func didUpdateNote() {
        self.txtViewNotes.text = userCellViewModel?.note
    }
}
