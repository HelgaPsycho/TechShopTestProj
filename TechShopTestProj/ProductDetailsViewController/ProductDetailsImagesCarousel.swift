//
//  ProductDetailsImagesCarousel.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 14.12.2022.
//

import UIKit

class ProductDetailsImagesCarousel: UIView {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: ProductCarouselLayout())
    
    var urls: [URL] = []
    var selectedIndex: Int = 0
    private var timer: Timer?
    
    public init(frame: CGRect, urls: [URL]) {
        self.urls = urls
        super.init(frame: frame)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // init from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        
        /*
         // Only override draw() if you perform custom drawing.
         // An empty implementation adversely affects performance during animation.
         override func draw(_ rect: CGRect) {
         // Drawing code
         }
         */
    }
        private func setupView() {
            collectionView.backgroundColor = .clear
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.isUserInteractionEnabled = true
            collectionView.isPagingEnabled = true
            
            
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(collectionView)
            collectionView.layer.masksToBounds = true
            collectionView.layer.cornerRadius = 10
            
            
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  0),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
            ])
            
            // scheduleTimerIfNeeded()
        }
        
        private func scheduleTimerIfNeeded() {
            guard urls.count > 1 else { return }
            timer?.invalidate()
            timer = Timer.scheduledTimer(
                withTimeInterval: 3.0,
                repeats: true,
                block: { [weak self] _ in
                    self?.selectNext()
                }
            )
        }
    
    private func selectNext() {
          selectItem(at: selectedIndex + 1)
      }
        
    private func selectItem(at index: Int) {
            let index = urls.count > index ? index : 0
            guard selectedIndex != index else { return }
            selectedIndex = index
            collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    
    func getImageStrings(_ imageStrings: [String]) {
        urls = imageStrings.compactMap{ URL(string:$0)}
        DispatchQueue.main.async { [self] in
        
          collectionView.reloadData()
    
            
        }
    
    }
    
        
}
extension ProductDetailsImagesCarousel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        return urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView: UIImageView = UIImageView(frame: .zero )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: urls[indexPath.row], placeholderImage: UIImage(named: "placeholder"))
        cell.contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0)
        ])
        return cell
    }
}

extension ProductDetailsImagesCarousel: UICollectionViewDelegate {
    
}
