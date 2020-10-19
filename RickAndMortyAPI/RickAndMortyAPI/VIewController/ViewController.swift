//
//  ViewController.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 13.10.2020.
//

import SnapKit

class ViewController: UIViewController {
    // MARK: - Properties
    
    var output: Presenter?
    
    var models: [CharacterModel] = []
    
    // MARK: - Life cycle
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        
        view.addSubview(tableView)
        
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        output?.getCharacters()
    }
}

// MARK: - Configuration

extension ViewController {
    func setupTableView() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellId)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorInset = .zero
        tableView.separatorColor = .black
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableView delegate & dataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellId, for: indexPath) as? TableViewCell else { fatalError("cant deque cell")}
        let model = models[indexPath.row]
        
        cell.configure(with: model)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

extension ViewController {
    func showModels(_ models: [CharacterModel]) {
        self.models = models
        
        tableView.reloadData()
    }
}

