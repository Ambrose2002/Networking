//
//  ViewController.swift
//  lec7
//
//  Created by Vin Bui on 10/31/23.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties (view)

    private let addBarButton = UIBarButtonItem()
    private let tableView = UITableView()
    private let refresh = UIRefreshControl()

    // MARK: - Properties (data)

    private var members: [Member] = []

    // MARK: - View Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "AppDev Roster FA23"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addNewMember)
        )

        setupTableView()
        fetchRoster()
    }

    // MARK: - Networking

    @objc private func addNewMember() {
        
        let newbie = Member(name: "Phillip Jones", subteam: "iOS", position: "Member")
        
        NetworkManager.shared.addToRoster(member: newbie) { [weak self] member in
            guard let self = self else {return}
            
            print("\(member.position) \(member.name) was added to the \(member.subteam) subteam")
        }
    }
    
    @objc private func fetchRoster() {
        NetworkManager.shared.fetchRoster { [weak self] members in
            guard let self else {return}
            
            self.members = members
            
            //perform UI update on main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refresh.endRefreshing()
            }
        }
    }

    // MARK: - Set Up Views

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: MemberTableViewCell.reuse)

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        refresh.addTarget(self, action: #selector(fetchRoster), for: .valueChanged)
        tableView.refreshControl = refresh

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemberTableViewCell.reuse) as? MemberTableViewCell else { return UITableViewCell() }
        let member = members[indexPath.row]
        cell.configure(member: member)
        return cell
    }

}
