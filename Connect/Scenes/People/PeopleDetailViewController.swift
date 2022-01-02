//
//  PeopleDetailViewController.swift
//  Connect
//
//  Created by Malak Badawy on 01/01/2022.
//

import UIKit

class PeopleDetailViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        }
    }
    @IBOutlet weak var jobTitleContainerView: UIView! {
        didSet {
            jobTitleContainerView.layer.cornerRadius = UIConstants.cornerRadius
        }
    }
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var phoneContainerView: UIView! {
        didSet {
            phoneContainerView.layer.cornerRadius = UIConstants.cornerRadius
        }
    }
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailContainerView: UIView! {
        didSet {
            emailContainerView.layer.cornerRadius = UIConstants.cornerRadius
        }
    }
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationContainerView: UIView! {
        didSet {
            locationContainerView.layer.cornerRadius = UIConstants.cornerRadius
        }
    }
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var favoriteColorContainerView: UIView! {
        didSet {
            favoriteColorContainerView.layer.cornerRadius = UIConstants.cornerRadius
        }
    }
    @IBOutlet weak var favoriteColorView: UIView! {
        didSet {
            favoriteColorView.layer.cornerRadius = favoriteColorView.frame.height / 2
        }
    }
    
    // MARK: - Public Properties
    
    var viewModel: PeopleViewModel?
    var selectedPerson: Person?
    var isDisplayedInCompactView: Bool?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if isDisplayedInCompactView ?? false {
            configureViews()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Private functions
    
    private func configureViews() {
        if let imageURL = URL(string: selectedPerson?.avatar ?? "") {
            avatarImageView.downloaded(from: imageURL)
        }
        nameLabel.text = viewModel?.retrieveFullName(firstName: selectedPerson?.firstName, lastName: selectedPerson?.lastName)
        jobTitleLabel.text = selectedPerson?.jobTitle
        phoneLabel.text = selectedPerson?.phone
        emailLabel.text = selectedPerson?.email
        favoriteColorView.backgroundColor = selectedPerson?.favouriteColor.hexStringToUIColor()
        displayAddress(for: selectedPerson!)
    }
    
    private func displayAddress(for person: Person) {
        viewModel?.getAddress(lat: person.latitude, long: person.longitude) { address in
            self.locationLabel.text = address
        }
    }
}

// MARK: - Person Selected Delegate

extension PeopleDetailViewController: PersonSelectedDelegate {
    func didSelect(person: Person, viewModel: PeopleViewModel?) {
        self.selectedPerson = person
        self.viewModel = viewModel
        configureViews()
    }
}
