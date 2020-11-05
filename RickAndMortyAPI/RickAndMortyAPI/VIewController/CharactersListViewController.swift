//
//  CharactersListViewController.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 13.10.2020.
//

import SnapKit

protocol CharactersListViewInput: class {
    func reloadData()
    func showModels(_ models: [Character])
}

class CharactersListViewController: UIViewController {
    
    // MARK: - Properties
    
    var output: CharactersListPresenter?
    
    var models: [Character] = []
        
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        #warning("если ты уже делаешь сетап внутри объявления вьюхи, то функция сетап тейбл вью тебе не нужна")
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
    #warning("убрать это")
    
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
        
        let loadCharactersButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(reloadData))
                
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
        
        guard let output = output else { return }
        output.getCharacters()
        models = output.charactersListFromRealm()
    }
}

// MARK: - Configuration

#warning("приватность")
extension CharactersListViewController {
    func setupTableView() {
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.cellId)
        
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

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        #warning("создать экстеншен")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.cellId, for: indexPath) as? CharacterCell else { fatalError("cant deque cell")}
        
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
        output?.createModelRealm(for: model)
    }
}

// MARK: - CharactersListViewInput

extension CharactersListViewController: CharactersListViewInput {
    func showModels(_ models: [Character]) {
        self.models = models
        
        tableView.reloadData()
    }
    
    @objc func reloadData() {
        tableView.reloadData()
        print("hello")
    }
}

