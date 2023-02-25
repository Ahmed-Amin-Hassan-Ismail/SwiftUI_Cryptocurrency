//
//  PortfolioDataService.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 20/02/2023.
//

import Foundation
import CoreData


final class PortfolioDataService {
    
    //MARK: - Properties
    
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    //MARK: Init
    
    init() {
        container = NSPersistentContainer(name: containerName)
        
        container.loadPersistentStores { [weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                
                print("Error loading core data \(error)! ")
                
            }
            
            self.getPortofolio()
        }
    }
    
    //MARK: - Public Method
    
    func updatePortfolio(coin: Coin, amoun: Double) {
        
        if let entity = savedEntities.first(where: { $0.coinId == coin.id }) {
         
            if amoun > 0 {
                
                update(entity: entity, amount: amoun)
                
            } else {
                
                delete(entity: entity)
                
            }
        } else {
            
            add(coin: coin, amount: amoun)
            
        }
    }
    
    
    //MARK: - Private Methods
    
    private func getPortofolio() {
        
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
            
        } catch {
            
            print("Error fetching from core data \(error)")
            
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinId = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        
        do {
        
            try container.viewContext.save()
            
        } catch {
            
            print("Error saving to core data \(error)")
            
        }
    }
    
    private func applyChanges() {
        
        save()
        getPortofolio()
        
    }
}
