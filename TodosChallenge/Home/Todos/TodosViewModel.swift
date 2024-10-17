//
//  TodoListViewModel.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//

import Combine
import SwiftUI

@Observable
class TodosViewModel {
    
    //MARK: - API
    private(set) var loadingState: LoadingState<SingleTodoViewModel> = .loading
    
    //MARK: - Constants
    
    //MARK: - Variables
    
    
}

enum LoadingState<T> {
    case loading
    case loaded(T)
    case error(Error)
}
  

