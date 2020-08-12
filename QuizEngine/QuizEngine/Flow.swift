//
//  Flow.swift
//  QuizEngine
//
//  Created by Hoff Henry Pereira da Silva on 30/07/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(result: [String:String])
}

class Flow {
    let router: Router
    let questions: [String]
    
    init(router: Router,
         questions: [String]) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(firstQuestion))
        } else {
            router.routeTo(result: [:])
        }
    }
    
    func routeNext(_ question: String) -> (String) -> Void {
        { [weak self]  _ in
            guard let self = self,
                let firstQuestionIndex = self.questions.firstIndex(of: question),
                firstQuestionIndex+1 < self.questions.count
                else { return }
            let nextQuestion = self.questions[firstQuestionIndex+1]
            self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(nextQuestion))
        }
    }
}
