//
//  ResultsViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 01.06.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: IB Outlet
    @IBOutlet var animalTypeLabel: UILabel!
    @IBOutlet var animalDefinitionLabel: UILabel!
    
    var answersChoosen: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true) //скрываем кнопку Back
        
        let calcAnimalTypes = calculationAnymalTypes(by: answersChoosen)
        let choosenAnimalType = selectMaxCountType(to: calcAnimalTypes)
        showDefinition(of: choosenAnimalType)
    }
}

// MARK: Private func
extension ResultsViewController {

    //Функция обрабатывает массив ответов и считает количество ответов с определённым AnimalType
    private func calculationAnymalTypes(by answers: [Answer]) -> [AnimalType: Int] {
        var countChoosenAnswerTypes: [AnimalType: Int] = [:]
        for answer in answers {
            if countChoosenAnswerTypes.keys.contains(answer.type) {
                countChoosenAnswerTypes[answer.type]! += 1
            } else {
                countChoosenAnswerTypes[answer.type] = 1
            }
        }
        return countChoosenAnswerTypes
    }

    //Выводит AnimalType с максимальным количеством ответов
    private func selectMaxCountType(to dictionary: [AnimalType: Int]) -> AnimalType {
        var animalType = AnimalType.dog  //Присваиваем любое свойство из AnymalType
        var maxCount = 0
        for (key, value) in dictionary {
            if value > maxCount {
                animalType = key
                maxCount = value
            }
        }
        return animalType
    }
    
    //Присваивает значение AnymalType лейблам
    private func showDefinition(of animalType: AnimalType) {
        animalTypeLabel.text = "Вы - \(animalType.rawValue)"
        animalDefinitionLabel.text = animalType.definition
    }
}
