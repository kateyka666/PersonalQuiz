//
//  QuestionsViewController.swift
//  Personal Quiz
//
//  Created by 18992227 on 31.05.2021.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet var rangedLabels: [UILabel]!
    
    static let segueIdentifier = "resultSegue"
    
    var questions: [Question] = []
    
    private var questionIndex = 0 // индекс активного вопроса
    
    private var answersChosen: [Answer] = [] // собираем ответы пользователя в массив
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
}
    

extension QuestionsViewController {

    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        //достаем список все текущих ответов из модели
        let currentAnswers = questions[questionIndex].answers
        
//        достаем текущие индекс ответа пользователя передавая баттон в метод ферстнидекс для массива всех кнопок
        guard let currentIndex = singleButtons.firstIndex(of: sender) else {
            return
        }
//        достаем текущий ответ пользователя из массива ответов по текущему индексу ответу пользователя
        let currentAnswer = currentAnswers[currentIndex]
        answersChosen.append(currentAnswer)
        
        nextQuestion()
    }

    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
//        добавляем все ответы пользователя, где он включил свитчер, в массив ответов пользователя
        for (switcher, answer) in zip(multipleSwitches, currentAnswers) {
            if switcher.isOn {
                answersChosen.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
                    
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
}

extension QuestionsViewController {
    private func updateUI() {
        // скрыть все стеки
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        // получить текущий вопрос
        let currentQuestion = questions[questionIndex]
        questionLabel.text = currentQuestion.text
        
        // подсчёт прогресса
        let totalProgress = Float(questionIndex) / Float(questions.count)
        progressView.setProgress(totalProgress, animated: true)
        
        // navigation title
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
//        получаем ответы для отображения в стеках
        let answers = currentQuestion.answers
        
        //    отображение определенного стека для определенного типа вопросов
        switch currentQuestion.type {
        case .single:
            updateSingleStackView(answers: answers)
        case .multiple:
            updateMultipleStackView(answers: answers)
        case .ranged:
            updateRangedStackView(answers: answers)
        }
    
    }

    private func updateSingleStackView(answers: [Answer]) {
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
        for switcher in multipleSwitches {
            switcher.isOn = false
        }
    }
    
    private func updateMultipleStackView(answers: [Answer]) {
        multipleStackView.isHidden = false
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.text
        }
    }
    
    private func updateRangedStackView(answers: [Answer]) {
        rangedStackView.isHidden = false
        
        rangedLabels.first?.text = answers.first?.text
        rangedLabels.last?.text = answers.last?.text
    }
    //    синг и мултиплай перемещаются к следующему стеку за текущим, а ренджт пермормит по сеге на след экран
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
//            обновляем ui в стеквью при ответе на вопрос
            updateUI()
        } else {
            performSegue(withIdentifier: QuestionsViewController.segueIdentifier, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == QuestionsViewController.segueIdentifier,
              let vc = segue.destination as? ResultViewController else {
            return
        }
        
        vc.answers = answersChosen
    }
}
