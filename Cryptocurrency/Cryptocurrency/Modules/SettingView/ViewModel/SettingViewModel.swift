//
//  SettingViewModel.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 21/06/2023.
//

import Foundation



class SettingViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var info: [PersonalInfo] = []
    @Published var bitCoinWebsite = URL(string: "https://bitcoin.org/en/")!
    
    
    init() {
        
        setupPersonalInfo()
    }
    
    
    //MARK: - PRIVATE
    
    private func setupPersonalInfo() {
        
        let list: [PersonalInfo] = [
            PersonalInfo(title: "Github",
                         image: "github",
                         url: URL(string: "https://github.com/Ahmed-Amin-Hassan-Ismail")!),
            
            PersonalInfo(title: "LinkedIn",
                         image: "linkedIn",
                         url: URL(string: "https://www.linkedin.com/in/ahmed-amin-hassan-6aa619212")!),
            
            PersonalInfo(title: "Facebook",
                         image: "facebook",
                         url: URL(string: "https://www.facebook.com/AhmedAminHassanIsmail")!)
                       
        ]
        
        self.info = list
    }
}
