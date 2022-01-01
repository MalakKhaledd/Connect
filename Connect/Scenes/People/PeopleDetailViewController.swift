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
            jobTitleContainerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var phoneContainerView: UIView! {
        didSet {
            phoneContainerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailContainerView: UIView! {
        didSet {
            emailContainerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationContainerView: UIView! {
        didSet {
            locationContainerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var favoriteColorContainerView: UIView! {
        didSet {
            favoriteColorContainerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var favoriteColorView: UIView! {
        didSet {
            favoriteColorView.layer.cornerRadius = favoriteColorView.frame.height / 2
        }
    }
    
    // MARK: - Public Properties
    
    var viewModel: PeopleViewModel?
    var selectedPersonID: String?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Private functions
    
    private func configureViews() {
        let person = viewModel?.people?.first { $0.id == selectedPersonID }
        if let imageURL = URL(string: person?.avatar ?? "") {
            avatarImageView.downloaded(from: imageURL)
        }
        nameLabel.text = viewModel?.retrieveFullName(firstName: person?.firstName, lastName: person?.lastName)
        jobTitleLabel.text = person?.jobTitle
        phoneLabel.text = person?.phone
        emailLabel.text = person?.email
        favoriteColorView.backgroundColor = hexStringToUIColor(hex: person?.favouriteColor ?? "")
        displayAddress(for: person!)
    }
    
    private func displayAddress(for person: Person) {
        viewModel?.getAddress(lat: person.latitude, long: person.longitude) { address in
            self.locationLabel.text = address
        }
    }
    
    func hexStringToUIColor(hex: String) -> UIColor {
        var colorString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (colorString.hasPrefix("#")) {
            colorString.remove(at: colorString.startIndex)
        }
        if ((colorString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt64 = 0
        Scanner(string: colorString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
