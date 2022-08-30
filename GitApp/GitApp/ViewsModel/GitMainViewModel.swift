//
//  GitMainViewModel.swift
//  GitApp
//
//  Created by BrainX 3096 on 29/08/2022.
//

import UIKit

class GitMainViewModel {
    
    //MARK: Public Properties
    let repoListRequest = RepoListApiManager()
    var selectedLanguages: [String] = []
    var filteredRepositories = [GitRepository]()
    private var gitRepositories = [GitRepository]() {
        didSet {
            filterRepositories(with: "")
        }
    }
    
    //MARK: Public Methods
    func fetchData(completion: @escaping (String?) -> Void) {
        repoListRequest.loadRepositories {response in
            switch response {
            case let .success(value):
                self.gitRepositories = value
                completion(nil)
            case let .failure(error):
                completion(error.message)
            }
        }
    }
    func repositoryFilteringbyLanguage(_ gitRepositoryArray: [GitRepository],
                                               _ languagesArray: [String])-> [GitRepository] {
        var repoFilter: [GitRepository] = []
        var index = 0
        for repo in gitRepositoryArray {
            if languagesArray.contains(repo.language ?? "") {
                repoFilter.insert(repo, at: index)
                index += 1
            }
        }
        return repoFilter
    }
    
    func filterLanguages() -> [GitRepository] {
        var filteredRepositories = [GitRepository]()
        guard !selectedLanguages.isEmpty else {
            return gitRepositories
        }
        for repo in gitRepositories {
            guard let name = repo.name,
                  let repoLanguage = repo.language?.lowercased() else {
                continue
            }
            if selectedLanguages.contains(where: { $0.lowercased() == repoLanguage }) {
                filteredRepositories.append(repo)
            }
        }
        return filteredRepositories
    }
    
    func filterRepositories(with text: String) {
        filteredRepositories.removeAll()
        let languageFiltered = filterLanguages()
        guard !text.isEmpty else {
            filteredRepositories = languageFiltered
            return
        }
        for repo in languageFiltered {
            guard let name = repo.name?.lowercased() else {
                continue
            }
            if name.contains(text.lowercased()) {
                filteredRepositories.append(repo)
            }
        }
    }
}
