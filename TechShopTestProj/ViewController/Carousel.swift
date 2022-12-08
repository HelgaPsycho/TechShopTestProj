//
//  Carousel.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 08.12.2022.
//

import UIKit

class Carousel: UIView {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: CarouselLayout())
    
    var urls: [URL] = []
    var hotSalesModelsArray: [HotSalesModel] = []
    var selectedIndex: Int = 0
    private var timer: Timer?

    public init(frame: CGRect, urls: [URL]){
        self.urls = urls
        super.init(frame: frame)
        setupView()
    }
    
    public init(frame: CGRect, urls: [URL], hotSales: [HotSalesModel]) {
        self.urls = urls
        super.init(frame: frame)
        self.hotSalesModelsArray = hotSales
        setupView()
    }
    
    //init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //init from xib or storyboard
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = true
        collectionView.isPagingEnabled = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
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
        guard urls.count > 1 else { return}
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: {[weak self] _ in self?.selectNext()
            
        })
    }
    
    private func selectNext() {
        selectItem(at: selectedIndex + 1)
    }
    
    private func selectItem(at index: Int){
        let index = urls.count > index ? index : 0
        guard selectedIndex != index else { return}
        selectedIndex = index
        collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
    }

}

extension Carousel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
      //  cell.layer.cornerRadius = 10
        let imageView: UIImageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.sd_setImage(with: urls[indexPath.row], placeholderImage: UIImage(named: "placeholder"))

        cell.contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cell.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: cell.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: cell.rightAnchor)
        ])
        
        // ЕСЛИ ЕСТЬ МАССИВ С ТЕКСТАМИ ДЛЯ ЛЕЙБЛОВ:
        guard hotSalesModelsArray.isEmpty == false else {return cell}
        
        //return getCellWithSetLabelsAndButton(indexPath: indexPath)
        return cell
    }
}

extension Carousel: UICollectionViewDelegate {
}

extension Carousel {
    
//    func getCellWithSetLabelsAndButton(indexPath: IndexPath)-> UICollectionViewCell {
//        var titleLabel: UILabel = {
//            let label = UILabel()
//            label.text = hotSalesModelsArray[indexPath.row].title
//            let font = UIFont()
//
//            label.font = UIFont()
//
//            label.textAlignment = .left
//            return label
//        }




       // return
   // }
}
