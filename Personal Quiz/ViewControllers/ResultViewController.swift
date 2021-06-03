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
        
       
            animalTypeResultLabel.text = "ВЫ - \(animalType.rawValue)"
            animalTypeDefinitionResultLabel.text = animalType.definition
        
    }
    private func maxCountOfAnimalType() -> AnimalType {
//        делаем словарь с типами животный и их колличеством в ответах
        var dictionaryOfAnimalsCount : [AnimalType : Int ] = [:]
//        достаем всех животных в новым массив
        let animals = answers.map {$0.type}
//        наполняем словарькладя в каждый тип животного количество повторений в массиве
        for animal in animals {
            dictionaryOfAnimalsCount[animal] = (dictionaryOfAnimalsCount[animal] ?? 0) + 1
        }
        
//сортируем словарь по большему значению
        let sortAnimal = dictionaryOfAnimalsCount.sorted {$0.value > $1.value}
        
//        берем тип из первого ключа, тк он самый большой и извлекаем опционал
        if let animalType = sortAnimal.first?.key {
            return animalType
        }
        return AnimalType.rabbit
    }
}

