//
//  MovieListPresenter.swift
//  learnMVP
//
//  Created by User on 13/10/2022.
//

import Foundation

protocol MovieListViewDelegate: AnyObject {
    func displayMovieList(model: [Movie])
}

class MovieListPresenter {
    
    // MARK: - Properties
    private let service: NetworkService
    weak private var movieListViewDelegate: MovieListViewDelegate?
    private var page = 1
    
    init(service: NetworkService) {
        self.service = service
    }
    
    // MARK: - Methods
    func setViewDelegate(viewDelegate: MovieListViewDelegate) {
        self.movieListViewDelegate = viewDelegate
    }
    
    func getMovieList() {
        service.getApi(with: Endpoints.discover(page), expecting: Discover.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.movieListViewDelegate?.displayMovieList(model: model.results)
            case .failure(let error):
                // this should be passed to the view
                print(error.localizedDescription)
            }
        }
    }
    
}
