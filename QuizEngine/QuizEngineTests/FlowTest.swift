//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Hoff Henry Pereira da Silva on 30/07/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine

class TestFlow: XCTestCase {
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        let router = RouterSpy()
        let sut = Flow(router: router, questions: [])
        sut.start()
        XCTAssertTrue (router.routedQuestions.isEmpty)
        
    }
    
    func test_start_withOneQuestion_routesToQuestion() {
        let router = RouterSpy()
        let question = ["One question"]
        let sut = Flow(router: router, questions: question)
        sut.start()
        XCTAssertEqual(router.routedQuestions, question)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestionQuestion() {
        let router = RouterSpy()
        let question = ["One question"]
        let sut = Flow(router: router, questions: question)
        sut.start()
        XCTAssertEqual(router.routedQuestions, question)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestionQuestion_2() {
        let router = RouterSpy()
        let question = ["Two question"]
        let sut = Flow(router: router, questions: question)
        sut.start()
        XCTAssertEqual(router.routedQuestions, question)
    }
    
    func test_start_withOneQuestion_routesToFirstQuestionQuestion() {
        let router = RouterSpy()
        let questions = ["One question", "Two question"]
        let sut = Flow(router: router, questions: questions)
        sut.start()
        XCTAssertEqual(router.routedQuestions,["One question"])
    }
    
    func test_startTwice_withOneQuestion_routesToFirstQuestionQuestionTwice() {
        let router = RouterSpy()
        let questions = ["One question", "Two question"]
        let sut = Flow(router: router, questions:questions)
        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["One question", "One question"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
        let router = RouterSpy()
        let questions = ["One question", "Two question"]
        let sut = Flow(router: router, questions:questions)
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["One question", "Two question"])
    }
        
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: ((String) -> Void) = { _ in }
        func routeTo(question: String, answerCallback: @escaping ((String) -> Void)) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
    
}


