//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import UIKit

class MovieDetailViewController: UIViewController {

// MARK: - Properties
    private let viewModel: MovieDetailViewModelType

    private lazy var tableView: UITableView = {
      let tableView = UITableView(frame: .zero, style: .plain)
      tableView.dataSource = self
      tableView.delegate = self
      tableView.showsVerticalScrollIndicator = false
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.contentInsetAdjustmentBehavior = .never
      tableView.separatorStyle = .singleLine
      tableView.rowHeight = UITableView.automaticDimension
      tableView.estimatedRowHeight = 100
      tableView.register(MovieDetailCell.self, forCellReuseIdentifier: MovieDetailCell.identifier)
      return tableView
    }()
    
    init(with viewModel: MovieDetailViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
}
 
// MARK: - Setup UI & Events
extension MovieDetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindToDataModel()
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.setConstrainsEqualToParent(edge: [.all])
    }
    
    func bindToDataModel() {
        viewModel.movieDetail.bind(listener: { [weak self] _ in
            self?.tableView.reloadData()
        })
    }
    
}

// MARK: - Table view data source
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: MovieDetailCell.self, for: indexPath)
        cell.setData(for: viewModel, row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


