//
//  PeopleMasterViewControllerTableViewController.swift
//  Connect
//
//  Created by Malak Badawy on 01/01/2022.
//

import UIKit

protocol PersonSelectedDelegate: AnyObject {
    func didSelect(person: Person, viewModel: PeopleViewModel?)
}

class PeopleMasterTableViewController: UITableViewController {
    // MARK: - Private Properties
    
    private var viewModel: PeopleViewModel?
    private var people: [Person]?
    
    // MARK: - Public Properties
    
    weak var delegate: PersonSelectedDelegate?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewModel()
        fetchPeople()
    }
    
    // MARK: - Private Functions
    
    private func configureTableView() {
        tableView.register(UINib(nibName: Constants.infoTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.infoTableViewCell)
    }
    
    private func configureViewModel() {
        viewModel = PeopleViewModel()
    }
    
    private func fetchPeople() {
        viewModel?.fetchPeople { [weak self] people, error in
            if error == nil {
                self?.people = people
                self?.reloadTable()
            }
        }
    }
    
    private func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.displayFirstPersonIfNotInCompactMode()
        }
    }
    
    private func displayFirstPersonIfNotInCompactMode() {
        if let splitViewController = splitViewController, !splitViewController.isCollapsed, let person = people?[0] {
            delegate?.didSelect(person: person, viewModel: viewModel)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.infoTableViewCell) as? InformationTableViewCell
        let person = people?[indexPath.row]
        cell?.configure(
            id: "",
            name: viewModel?.retrieveFullName(firstName: person?.firstName, lastName: person?.lastName) ?? "",
            maxOccupancy: "",
            occupancy: ""
        )
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIConstants.roomsTableViewCellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPerson = people?[indexPath.row]
        if let splitViewController = splitViewController {
            if splitViewController.isCollapsed {
                let personViewController = storyboard?.instantiateViewController(withIdentifier: "PeopleDetailViewController") as? PeopleDetailViewController
                personViewController?.selectedPerson = selectedPerson
                personViewController?.viewModel = viewModel
                personViewController?.isDisplayedInCompactView = true
                navigationController?.pushViewController(personViewController!, animated: true)
            } else {
                let personViewController = storyboard?.instantiateViewController(withIdentifier: "PeopleDetailViewController") as? PeopleDetailViewController
                personViewController?.isDisplayedInCompactView = false
                delegate?.didSelect(person: selectedPerson!, viewModel: viewModel)
            }
        }
    }
}
