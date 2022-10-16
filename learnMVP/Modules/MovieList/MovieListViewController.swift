//
//  MovieListViewController.swift
//  learnMVP
//
//  Created by User on 13/10/2022.
//

import UIKit

class MovieListViewController: UIViewController, MovieListViewDelegate {
    
    // MARK: - Properties
    private let presenter = MovieListPresenter(service: NetworkService())
    private var movieList: [Movie]?

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(viewDelegate: self)
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        setupTableView()
        presenter.getMovieList()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Methods
    func displayMovieList(model: [Movie]) {
        self.movieList = model
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = movieList else { return UITableViewCell() }
        let movie = model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = movie.originalTitle
        return cell
    }
    
}
