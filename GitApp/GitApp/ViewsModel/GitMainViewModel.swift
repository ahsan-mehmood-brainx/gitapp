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
    var gitRepositories = [GitRepository]()
    var searchRepositories: [GitRepository] = []
    var languagesRepositories: [GitRepository]!
    var searchAndLanguageRepositories = [GitRepository]()
    
    //MARK: Public Method
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
    
    //MARK: Private Method
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
    func isLanguageSelected()->Bool {
        if !selectedLanguages.isEmpty {
            languagesRepositories =  repositoryFilteringbyLanguage(gitRepositories, selectedLanguages)
            return true
        }
        else {
            return false
        }
    }
}
