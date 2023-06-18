//
//  PortfolioDataService.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 18/06/2023.
//

import Foundation
import CoreData



final class PortfolioDataService {
    
    //MARK: - Properties
    
    @Published var savedPortfolioData: [PortfolioItem]?
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: containerName)
        loadPersistentStores(container)
        
        return container
    }()
    
    private let containerName = "Portfolio"
    private let entityName = "PortfolioItems"
    
    
    //MARK: PUBLIC
    
    func updatePortfolio(coin: Coin, amount: Double) {
        
        if let portfolio = savedPortfolioData?.first(where: { $0.coinId == coin.id }) {
            
            if amount > 0 {
                
                update(portfolio: portfolio, amount: amount)
                
            } else {
                
                delete(portfolio: portfolio)
            }
            
        } else {
            
            add(coin: coin, amount: amount)
        }
    }
    
    
    //MARK: - PRIVATE
    
    private func loadPersistentStores(_ container: NSPersistentContainer ) {
        container.loadPersistentStores { [weak self] data, error in
            guard let self = self else { return }
            guard error == nil else {
                print("Error Loading Core Data ! \(error!.localizedDescription)")
                return
            }
            
            self.fetchPortfolioData()
        }
    }
    
    private func fetchPortfolioData() {
        let request = NSFetchRequest<PortfolioItem>(entityName: entityName)
        
        do {
            
            savedPortfolioData = try container.viewContext.fetch(request)
            
        } catch {
            print("Error Fetching Portfolio Data \(error.localizedDescription)")
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let portfolio = PortfolioItem(context: container.viewContext)
        portfolio.coinId = coin.id
        portfolio.amount = amount
        
        applyChanges()
    }
    
    
    private func update(portfolio: PortfolioItem, amount: Double) {
        portfolio.amount = amount
        
        applyChanges()
    }
    
    private func delete(portfolio: PortfolioItem) {
        
        container.viewContext.delete(portfolio)
        
        applyChanges()
    }
    
    
    private func save(completionHandler: @escaping () -> Void) {
        do {
            
            try container.viewContext.save()
            completionHandler()
            
        } catch {
            print("Error Saving into Core Data \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        save { [weak self] in
            guard let self = self else { return }
            self.fetchPortfolioData()
        }
    }
}
