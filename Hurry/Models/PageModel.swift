//
//  PageModel.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 07.04.2022.
//

import Foundation
import UIKit

struct PageModel {
    let title: String
    let description: String
    let image: UIImage
    
    static func getPages() -> [PageModel] {
        let descriptionHurry = """
        With "Hurry" you can order a cap of
        coffee online in your favorite coffee shop,
        then you can pick it up at your convenience!
        Press "next" button and you will be
        directed to the "what's next?" screen.
        """
        
        let descriptionNext = """
        Press the "get started" button and you
        will be directed to the sign up / sign in screen.
        Sign up or sign in and let's go to coffee shops!
        Choose the one you like and order your favorite drinks.
        Let's go?
        """
        
        guard let imageOne = UIImage(named: "manWithCup")
        else { return [] }
        guard let imageTwo = UIImage(named: "manWithCap2")
        else { return [] }
        
        return [
            PageModel(title: "What is Hurry?",
                      description: descriptionHurry,
                      image: imageOne),
            PageModel(title: "What's next?",
                      description: descriptionNext,
                      image: imageTwo)
        ]
    }
}
