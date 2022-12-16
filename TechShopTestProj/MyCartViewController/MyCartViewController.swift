//
//  MyCartViewController.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 11.12.2022.
//

import UIKit

class MyCartViewController: UIViewController {
    
    var myCartManager = MyCartManager()
    public weak var delegate: MyCartControllerDelegate?
    lazy var productModel: [ProductModel] = []
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backButton: UIButton = UIButton().getBackButton(with: "back.png")
    
    private lazy var adressButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "peach") ?? UIColor.orange
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "adress.png"), for: .normal)
        
        button.widthAnchor.constraint(equalToConstant:  40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
       // button.addTarget(self, action: #selector(  ), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var topViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.black
        label.text = "Add adress"
        label.textAlignment = .right
        let font = UIFont(name: "MarkPro-Medium", size: 15)
        label.font = font
        return label
    }()
    
    
    private lazy var titleView = UIView()
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Cart"
        let font = UIFont(name: "MarkPro-Bold", size: 35)
        label.font = font
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    
    private var tableViewConteiner: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "indigo") ?? UIColor.black
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "indigo") ?? UIColor.black
        return tableView
    }()
   
    private lazy var totalPriceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "indigo") ?? UIColor.black
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "darkSilver")?.cgColor ?? UIColor.darkGray.cgColor
        return view
    }()

    private lazy var totalAndDeliveryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        return stackView
    }()
    
    
    private lazy var labelsForTotalAndDeliveryStackView: [UILabel] = []
    private func getLabelsToTotalAndDeliveryStackView(with strings: [String]) -> [UILabel] {
        var labels: [UILabel] = []
        for string in strings {
            let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.text = string
                    let font = UIFont(name: "MarkPro-Regular", size: 15)
                    label.font = font
                    label.textColor = UIColor.white
                    label.textAlignment = .left
            labels.append(label)
        }
        return labels
    }
    
    private lazy var costStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var totalCostLabel: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = ""
                let font = UIFont(name: "MarkPro-Bold", size: 15)
                label.font = font
                label.textColor = UIColor.white
                label.textAlignment = .left
                return label
    }()
    
    private lazy var delivaryCostLabel: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = ""
                let font = UIFont(name: "MarkPro-Bold", size: 15)
                label.font = font
                label.textColor = UIColor.white
                label.textAlignment = .left
                return label
    }()
    
    
    private lazy var checkoutButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "indigo") ?? UIColor.black
        return view
    }()
    
    private lazy var checkoutButton: UIButton = UIButton().getBigOrangeButton(named: "Checkout")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        myCartManager.delegate = self
        myCartManager.fetchMyCartInfo()
        setupView()
        setupHierarhy()
        setupConstraints()
       
    }
    
    func configureTableView() {
    
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        tableView.register(TableViewProductCell.self, forCellReuseIdentifier: "cell")

    }
    
    func setupView(){
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "lightSilver") ?? UIColor.lightGray
        titleView.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(navigateBackToProductsDetailController), for: .touchUpInside)
    }
    
    private func setupHierarhy(){
        view.addSubview(topView)
        topView.addSubview(backButton)
        topView.addSubview(adressButton)
        topView.addSubview(topViewLabel)
        view.addSubview(titleView)
        titleView.addSubview(titleLable)
        view.addSubview(checkoutButtonView)
        checkoutButtonView.addSubview(checkoutButton)
        view.addSubview(tableViewConteiner)
        tableViewConteiner.addSubview(tableView)
        view.addSubview(totalPriceView)
        totalPriceView.addSubview(totalAndDeliveryStackView)
        for label in getLabelsToTotalAndDeliveryStackView(with:["Total", "Delivery"]){
            totalAndDeliveryStackView.addArrangedSubview(label)
        }
        totalPriceView.addSubview(costStackView)
        costStackView.addArrangedSubview(totalCostLabel)
        costStackView.addArrangedSubview(delivaryCostLabel)
    }

    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/10),
            
            backButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            backButton.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 40),
            
            adressButton.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -40),
            adressButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            topViewLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topViewLabel.rightAnchor.constraint(equalTo: adressButton.leftAnchor, constant: -5),
            
            titleView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            titleView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            titleView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            titleView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/15),

            titleLable.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLable.leftAnchor.constraint(equalTo: titleView.leftAnchor),
            
            checkoutButtonView.leftAnchor.constraint(equalTo: view.leftAnchor),
            checkoutButtonView.rightAnchor.constraint(equalTo: view.rightAnchor),
            checkoutButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            checkoutButtonView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.5/10),
            
            checkoutButton.centerXAnchor.constraint(equalTo: checkoutButtonView.centerXAnchor),
            checkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            totalPriceView.bottomAnchor.constraint(equalTo: checkoutButtonView.topAnchor),
            totalPriceView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -1),
            totalPriceView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 1),
            totalPriceView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10),
            
            totalAndDeliveryStackView.leftAnchor.constraint(equalTo: totalPriceView.leftAnchor, constant: 50),
            totalAndDeliveryStackView.rightAnchor.constraint(equalTo: totalPriceView.centerXAnchor),
            totalAndDeliveryStackView.topAnchor.constraint(equalTo: totalPriceView.topAnchor),
            totalAndDeliveryStackView.bottomAnchor.constraint(equalTo: totalPriceView.bottomAnchor, constant: -10),
            
            costStackView.leftAnchor.constraint(equalTo: totalPriceView.centerXAnchor, constant: 70),
            costStackView.rightAnchor.constraint(equalTo: totalPriceView.rightAnchor, constant: -30),
            costStackView.topAnchor.constraint(equalTo: totalPriceView.topAnchor),
            costStackView.bottomAnchor.constraint(equalTo: totalPriceView.bottomAnchor, constant: -10),
            
            tableViewConteiner.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10),
            tableViewConteiner.bottomAnchor.constraint(equalTo: totalPriceView.topAnchor, constant: 30),
            tableViewConteiner.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableViewConteiner.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            tableView.rightAnchor.constraint(equalTo: tableViewConteiner.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: tableViewConteiner.leftAnchor),
            tableView.topAnchor.constraint(equalTo: tableViewConteiner.topAnchor, constant: 70),
            tableView.bottomAnchor.constraint(equalTo: totalPriceView.topAnchor)
            
            
        ])
    }
}

extension MyCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
    
    
 
extension MyCartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewProductCell else { fatalError("could not dequeueReausablleCell") }
        print("TABLE VIEW CELL FOR ROW AT CALLED")
      //  cell.translatesAutoresizingMaskIntoConstraints = false
       // cell.heightAnchor.constraint(equalToConstant: 120).isActive = true
        cell.data = self.productModel[indexPath.row]
        return cell
            
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

extension MyCartViewController {
    
    @objc func navigateBackToProductsDetailController(sender: UIButton) {
        print("1 BACK TO PRODUCT DETAIL CONTROLLER BUTTON PRESSED")
        self.delegate?.navigateBackToLastController()
        
    }
    
   
}


extension MyCartViewController: MyCartManagerDelegate {
    
    func didUpdateMyCart(_ myCartManager: MyCartManager, myCart: MyCartModel) {
        DispatchQueue.main.async { [self] in
            delivaryCostLabel.text = myCart.delivery
            totalCostLabel.text = String(myCart.total)
            
            //   formationView.setupModel(model: productDetails)
        }
       
    }
    
    func didUpdateBasketProducts(_ myCartManager: MyCartManager, productsDetails: [ProductModel]) {
        productModel = productsDetails
        DispatchQueue.main.async { [self] in
        tableView.reloadData()
            
        }
    }
    
    func didFailWithError(error: Error) {
    
            print ("error")
    }
    
}
