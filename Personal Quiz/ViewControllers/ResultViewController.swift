//
//  ResultViewController.swift
//  Personal Quiz
//
//  Created by 18992227 on 31.05.2021.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var animalTypeResultLabel: UILabel!
    @IBOutlet weak var animalTypeDefinitionResultLabel: UILabel!
    // 1. Массив ответов
    // 2. Определить наиболее часто встречаемый тип животного
    // 3. Отобразить результат
    // 4. Избавиться от кнопки Back
    
    var answers: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabelsAndBackButton()
    }
    
}

extension ResultViewController {
    private func setupLabelsAndBackButton() {
        navigationItem.hidesBackButton = true
        
       let animalType = maxCountOfAnimalType()
        
        switch animalType {
        case .dog:
            animalTypeResultLabel.text = "ВЫ - \(AnimalType.dog.rawValue)"
            animalTypeDefinitionResultLabel.text = AnimalType.dog.definition
        case .cat:
            animalTypeResultLabel.text = "ВЫ - \(AnimalType.cat.rawValue)"
            animalTypeDefinitionResultLabel.text = AnimalType.cat.definition
        case .rabbit:
            animalTypeResultLabel.text = "ВЫ - \(AnimalType.rabbit.rawValue)"
            animalTypeDefinitionResultLabel.text = AnimalType.rabbit.definition
        case .turtle:
            animalTypeResultLabel.text = "ВЫ - \(AnimalType.turtle.rawValue)"
            animalTypeDefinitionResultLabel.text = AnimalType.turtle.definition
        }
    }
    private func maxCountOfAnimalType() -> AnimalType {
        
//        сделали расширение, подписались под протокол и тепреь считаем сколько типов животных по количеству, складываем в словарь
        let counts = answers.counting
        print(counts)
//сортируем словарь по большему значению
        let sortAnimal = counts.sorted {$0.value > $1.value}
        print(sortAnimal)
//        берем тип из первого ключа, тк он самый большой и извлекаем опционал
        if let animalType = sortAnimal.first?.key.type {
            return animalType
        }
        return AnimalType.rabbit
    }
}

