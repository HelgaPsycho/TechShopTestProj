//
//  Carousel.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 08.12.2022.
//

import UIKit
import Combine

class Carousel: UIView {
    
//    var data: [HotSalesModel]? {
//        didSet {
//            guard let data = data else {return}
//            hotSalesModelsArray = data
//            
//        }
//    }
    
    private var api = StoreAPIForHotSales()
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: CarouselLayout())
    
    var hotSalesAndBestSellersManager = HotSalesAndBAstSellersManager()
    
 //   var urls: [URL] = []
  //  lazy var hotSalesModelsArray: [HotSalesModel] = [HotSalesModel(id: 0, isNew: true, title: "IPhone", subtitle: "супер телефон", picture: URL(string:"https://img.ibxk.com.br/2020/09/23/23104013057475.jpg?w=1120&h=420&mode=crop&scale=both")!, isBuy: false), HotSalesModel(id: 1, isNew: false, title: "IPhone", subtitle: "супер телефон", picture: URL(string: "https://img.ibxk.com.br/2020/09/23/23104013057475.jpg?w=1120&h=420&mode=crop&scale=both")!, isBuy: false)]
    
   var hotSalesModelsArray: [HotSalesModel] = []
    
    var selectedIndex: Int = 0
    private var timer: Timer?
    
//    fileprivate func getHotSalesProducts() {
//        api.hotSalesProducts()
//            .receive(on: DispatchQueue.main)
//            .sink {(hotSalesProducts) in
//                self.hotSalesArray = hotSalesProducts
//                self.collectionView.reloadData()
//            }
//            .store(in: &self.cancellable)
//        print(hotSalesArray)
//    }
    
    public init(frame: CGRect, data: [HotSalesModel]) {
        print(data)
        self.hotSalesModelsArray = data
        super.init(frame: frame)
        print("DATA: \(data)")
        print("HOT SALES ARRAY: \(hotSalesModelsArray)")
        setupView()
    }
    
    //init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        //getHotSalesProducts()
        setupView()
    }
    
    //init from xib or storyboard
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    private func setupView(){
        hotSalesAndBestSellersManager.delegate = self
        hotSalesAndBestSellersManager.fetchHotSales()

        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = true
        collectionView.isPagingEnabled = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        
        collectionView.register(HotSalesCell.self, forCellWithReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor)
            
        ])
        //ТАЙМЕР, ПЕРЕЛИСТЫВАЮЩИЙ ЯЧЕЙКИ МОЖНО ВКЛЮЧИТЬ ПРИ НЕОБХОДИМОСТИ
      //  scheduleTimerIfNeeded()
    }
    
    private func scheduleTimerIfNeeded() {
        guard hotSalesModelsArray.count > 1 else { return}
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: {[weak self] _ in self?.selectNext()
            
        })
    }
    
    private func selectNext() {
        selectItem(at: selectedIndex + 1)
    }
    
    private func selectItem(at index: Int){
        let index = hotSalesModelsArray.count > index ? index : 0
        guard selectedIndex != index else { return}
        selectedIndex = index
        collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
   
}

extension Carousel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hotSalesModelsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HotSalesCell
        cell.data = self.hotSalesModelsArray[indexPath.item]
        return cell
        
    
    }
}

extension Carousel: UICollectionViewDelegate {
    
}


extension Carousel: DelegateFlowLayout {
    func sizeForItemAt() {
        
    }
}

extension Carousel: HotSalesAndBestSellersManagerDelegate {
    func didUpdateHotSales(_ hotSalessManager: HotSalesAndBAstSellersManager, hotSales: [HotSalesModel]){
        DispatchQueue.main.async { [self] in
        
            hotSalesModelsArray = hotSales
            collectionView.reloadData()
        
            
        }
        
    }
    func didUpdateBestSellers(_ hotSalesAndBestSellersManager: HotSalesAndBAstSellersManager, bestSellers: [BestSellersModel]){
        
    }
    func didFailWithError(error: Error)
    {}
}

