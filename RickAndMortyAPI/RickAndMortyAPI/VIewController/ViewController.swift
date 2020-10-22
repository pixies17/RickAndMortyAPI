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
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        
        view.addSubview(tableView)
        
        return tableView
    }()
    
    lazy var navigationBar: UINavigationBar = {
       let navBar = UINavigationBar()

        navigationItem.rightBarButtonItem = loadCharactersButton
        navigationItem.title = "Персонажи"
        view.addSubview(navBar)

        return navBar
    }()
    
//    lazy var navigaionControllerName: UINavigationItem = {
//       let navigaionControllerName = UILabel()
//        navigaionControllerName.text = "Персонажи"
//        navigaionControllerName.font = .systemFont(ofSize: 20, weight: .bold)
//        
//        let navigaionControllerNameItem = UINavigationItem()
//        navigationBar.setItems([navigaionControllerNameItem], animated: false)
//        
//        return navigaionControllerNameItem
//    }()
    
    var loadCharactersButton: UIBarButtonItem = {
//        let loadCharactersButton = UIButton()
//        loadCharactersButton.setImage(.add, for: .normal)
//        loadCharactersButton.addTarget(self, action: #selector(reloadTableView), for: .touchDown)
        
        let loadCharactersButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(reloadTableView))
                
        return loadCharactersButtonItem
    }()
    
    // MARK: - Life cycle
    
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
        navigationBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = models[indexPath.row]
        output?.saveModel(from: model)
    }
}

extension ViewController {
    func showModels(_ models: [CharacterModel]) {
        self.models = models
        
        tableView.reloadData()
    }
    
    @objc func reloadTableView() {
        tableView.reloadData()
        print("hello")
    }
}

