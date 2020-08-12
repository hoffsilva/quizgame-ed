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
    
    let router = RouterSpy()
    
    func createSUT(_ questions: [String]) -> Flow {
        Flow(router: router, questions: questions)
    }
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        createSUT([]).start()
        XCTAssertTrue (router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToQuestion() {
        let question = ["One question"]
        createSUT(question).start()
        XCTAssertEqual(router.routedQuestions, question)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestionQuestion() {
        let question = ["One question"]
        createSUT(question).start()
        XCTAssertEqual(router.routedQuestions, question)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestionQuestion_2() {
        let question = ["Two question"]
        createSUT(question).start()
        XCTAssertEqual(router.routedQuestions, question)
    }
    
    func test_start_withOneQuestion_routesToFirstQuestionQuestion() {
        let questions = ["One question", "Two question"]
        createSUT(questions).start()
        XCTAssertEqual(router.routedQuestions,["One question"])
    }
    
    func test_startTwice_withOneQuestion_routesToFirstQuestionQuestionTwice() {
        let questions = ["One question", "Two question"]
        let sut = createSUT(questions)
        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["One question", "One question"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
        let questions = ["One question", "Two question"]
        let sut = createSUT(questions)
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["One question", "Two question"])
    }
    
    func test_startAndAnswerFirstandSecondQuestion_withTwoQuestions_routesToSecondAndThirdQuestion() {
        let questions = ["One question", "Two question", "Three question"]
        let sut = createSUT(questions)
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedQuestions, ["One question", "Two question", "Three question"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestions_doesNotRouteToAnotherQuestion() {
        let questions = ["One question"]
        let sut = createSUT(questions)
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["One question"])
    }
    
    func test_start_withNoQuestions_routesToResult() {
        createSUT([]).start()
        XCTAssertEqual(router.routedResult, [:])
    }
        
    class RouterSpy: Router {
        
        var routedQuestions: [String] = []
        var routedResult: [String:String]? = nil
        var answerCallback: ((String) -> Void) = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping ((String) -> Void)) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: [String : String]) {
            routedResult = result
        }
    }
    
}


