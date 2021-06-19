//
//  NewsViewModel.swift
//  TempoMobileTask
//
//  Created by mina wefky on 18/06/2021.
//

import Foundation
import RxSwift

struct NewsViewModel {
    
    // MARK: - variables
    var newsSubject = PublishSubject<NewsModel>()
    var disposeBag = DisposeBag()
    
    // MARK: - fetch news with input text 
    func fetchNews(with text: String, page: Int) {
        if text == "" {
            return
        }
        ApiClient.getNews(searchText: text, page: page)
            .subscribe { newsList in
                newsSubject.onNext(newsList)
            } onError: { error in
                newsSubject.onError(error)
            }.disposed(by: disposeBag)

    }
}
