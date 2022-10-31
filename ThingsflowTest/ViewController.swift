//
//  ViewController.swift
//  ThingsflowTest
//
//  Created by Channoori Park on 2022/10/28.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var repositories: [Repository] = []
    var organizationName: String = "apple"
    var repositoryName: String = "swift"
    
    var refreshTimer: Timer? = nil
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var searchBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(onSearch))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.refreshTimer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(onRefresh), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.refreshTimer?.invalidate()
        self.refreshTimer = nil
    }
    
    func initUI() {
        self.navigationItem.rightBarButtonItem = searchBtn
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.idenftifier)
        tableView.register(ImageBannerTableViewCell.self, forCellReuseIdentifier: ImageBannerTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func initData() {
        self.organizationName = UserDefaults.standard.string(forKey: "organization") ?? "apple"
        self.repositoryName = UserDefaults.standard.string(forKey: "repository") ?? "swift"
        self.title = "\(organizationName)/\(repositoryName)"
        APIService.shared.getRepository(organizationName, repositoryName) { [weak self] repositorys, errorMsg in
            guard let self = self else { return }
            if let response = repositorys {
                self.repositories = response
                self.tableView.reloadData()
            } else {
                guard let msg = errorMsg else { return }
                self.alert(msg: msg)
            }
        }
    }
    
    @objc func onRefresh() {
        APIService.shared.getRepository(organizationName, repositoryName) { [weak self] repositorys, errorMsg in
            guard let self = self else { return }
            if let response = repositorys {
                self.repositories = response
                self.tableView.reloadData()
            } else {
                guard let msg = errorMsg else { return }
                self.alert(msg: msg)
            }
        }
    }
    
    @objc func onSearch() {
        self.alertInput { organization, repository in
            if organization.count > 0, repository.count > 0 {
                APIService.shared.getRepository(organization, repository) { [weak self] repositorys, errorMsg in
                    guard let self = self else { return }
                    if let response = repositorys {
                        self.title = "\(organization)/\(repository)"
                        UserDefaults.standard.set(organization, forKey: "organization")
                        UserDefaults.standard.set(repository, forKey: "repository")
                        self.repositories = response
                        self.tableView.reloadData()
                    } else {
                        guard let msg = errorMsg else { return }
                        self.alert(msg: msg)
                    }
                }
            } else {
                self.alert(msg: "빈 칸을 확인해 주세요.")
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count > 0 ? repositories.count + 1 : repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageBannerTableViewCell.identifier, for: indexPath)as? ImageBannerTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.configure()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.idenftifier, for: indexPath)as? RepositoryTableViewCell else { return UITableViewCell() }
            let data = indexPath.row > 4 ? repositories[indexPath.row-1] : repositories[indexPath.row]
            cell.selectionStyle = .none
            cell.configure(data)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            if let url = URL(string: "http://thingsflow.com/ko/home") {
                UIApplication.shared.open(url)
            }
        } else {
            let data = indexPath.row > 4 ? repositories[indexPath.row-1] : repositories[indexPath.row]
            let detail = DetailIssueViewController(repository: data)
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
}

