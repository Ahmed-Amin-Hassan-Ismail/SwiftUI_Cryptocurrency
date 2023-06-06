//
//  PreviewProvider+EXT.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 06/06/2023.
//

import SwiftUI


extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        
        return DeveloperPreview.instance
    }
    
}


final class DeveloperPreview {
    
    //MARK: - Singleton
    
    static let instance = DeveloperPreview()
    
    private init() { }
    
    let coin = Coin (
        id: "bitcoin",
        symbol: "bte",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
        currentPrice: 61408,
        marketCap: 1141731099010,
        marketCapRank: 1,
        fullyDilutedValuation: 1285385611303,
        totalVolume: 67190952980,
        high24H: 61712,
        low24H: 56220,
        priceChange24H: 3952.64,
        priceChangePercentage24H: 6.87944,
        marketCapChange24H: 72110681879,
        marketCapChangePercentage24H: 6.74171,
        circulatingSupply: 18653043,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 61712,
        athChangePercentage: -0.97589,
        athDate: "2021-03-13720:49:26.606Z",
        atl: 67.81,
        atlChangePercentage: 90020.24075,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2021-03-13723:18:10.268Z",
        sparklineIn7D: SparklineIn7D(price: [
        54019.26878317463,
        53718.060935791524,
        53677.12968669343,
        53848.3814432924,
        53561.593235320615,
        53456.0913723206,
        53888.97184353125,
        54796.37233913172,
        54593.507358383504,
        54582.558599307624,
        54635.7248282177,
        55192.54513921453,
        54878.11598538206,
        54513.95881205807,
        55013.68511841942,
        55145.89456844788,
        54718.37455337104,
        54954.0493828267,
        54910.13413954234,
        54778.58411728141,
        55027.87934987173,
        55473.06577779744,
        54997.291345118225,
        54991.81484262107,
        55395.61328972238,
        55530.513360661644,
        55344.4499292381,
        54889.00473869075,
        54844.521923521665,
        54621.36137575708,
        54513.628030530825,
        54356.00127005116,
        53755.786684715764,
        54024.540451750094,
        54385.912857981304,
        54399.67618552436,
        53991.52168768531,
        54683.32533920595,
        54449.31811384671,
        54409.102042970466,
        54370.86991701537,
        53731.669170540394,
        53841.45014070333,
        53078.52898275558,
        52881.63656182149,
        53010.25164880975,
        52936.11939761323,
        52937.55256563505,
        53413.673939003136,
        53395.17699522727,
        53596.70402266675,
        53456.22811013035,
        53483.547854166834,
        53574.40015717944,
        53681.336964452734,
        54101.59049997355,
        54318.29276391888,
        54511.25370785759,
        54332.08597577831,
        54577.323438764404,
        54477.276388342325,
        54289.676338302765,
        54218.42837403623,
        54802.18754896328,
        55985.49640087922,
        56756.316501699876,
        57787.23755822543,
        58021.66564986657,
        57899.998011485266,
        58833.861160841436,
        58789.11830069634,
        58491.11446437883,
        58493.58897378262,
        58757.30471138256,
        58554.84171574884,
        57839.05673758758,
        57992.34121354044,
        57699.960140573115,
        57771.20058181922,
        58080.643272295056,
        57831.48061892176,
        57430.1839517489,
        56969.140564644826,
        57154.57504790339,
        57336.828870254896
        ]),
        priceChangePercentage24HInCurrency: 3952.64,
        currentHoldings: 1.5
    )
    
}

