//
//  CompleteOrderVC.swift
//  eShtry
//
//  Created by eslam mohamed on 12/03/2022.
//

import UIKit

class CompleteOrderVC: UIViewController {
    
    let headerView        = DefaultView(color: UIColor(red: 23/255, green: 69/255, blue: 167/255, alpha: 1), raduis: 0)
    let titleLabel        = DefaultTitleLabel(textAlignment: .center, fontSize: 18, fontColor: .white)
    let returnBtn         = ImageButton(typeOfBtn: .returnBtn)
    let scrollView          = UIScrollView()
    let containerView     = DefaultView(color: .clear, raduis: 0)
    
    let shipmentLabel     = DefaultTitleLabel(textAlignment: .left, fontSize: 18, fontColor: .black)
    let shipmentView      = DefaultView(color: .white, raduis: 10)
    let shipmentimgView   = DefaultImageView(frame: .zero)
    let shipmentTitle     = DefaultTitleLabel(textAlignment: .left, fontSize: 16, fontColor: .black)
    let shipmentDescription = SeconderyTitleLabel(textAlignment: .left, fontSize: 13, fontColor: .black)
    
    let itemsLabel   = DefaultTitleLabel(textAlignment: .left, fontSize: 18, fontColor: .black)
    let itemsView    = DefaultView(color: .white, raduis: 10)
    let shipmentNumLabel = DefaultTitleLabel(textAlignment: .left, fontSize: 16, fontColor: .black)
    let deliveryDate = DefaultTitleLabel(textAlignment: .left, fontSize: 15, fontColor: .black)
    var itemsCollection: UICollectionView!
    
    let bottomView        = TopRoundView(raduis: 15,color: .white)
    let grandTotalLabel     = DefaultTitleLabel(textAlignment: .left, fontSize: 18, fontColor: .black)
    let numberOfItems     = SeconderyTitleLabel(textAlignment: .left, fontSize: 15, fontColor: .black)
    let cashLabel         = DefaultTitleLabel(textAlignment: .left, fontSize: 18, fontColor: .black)
    let descriptionLabel  = SeconderyTitleLabel(textAlignment: .left, fontSize: 15, fontColor: .black)
    
    let checkoutBtn       = DefaultButton(btnTitle: "PLACE ORDER".localized, titleColor: .white, backgroundColor: UIColor(red: 255/255, green: 0, blue: 5/255, alpha: 1), raduis: 10)

    let paymentMethodLabel = DefaultTitleLabel(textAlignment: .left, fontSize: 18, fontColor: .black)
    let paymentView        = DefaultView(color: .white, raduis: 10)
    let payOnDelivery      = DefaultButton(btnTitle: "payOnDelivery".localized, titleColor: .black, backgroundColor: .clear, raduis: 0)
    let payOnline      = DefaultButton(btnTitle: "payOnline".localized, titleColor: .black, backgroundColor: .clear, raduis: 0)

    
    let orderSummaryLabel = DefaultTitleLabel(textAlignment: .left, fontSize: 18, fontColor: .black)
    let orderSummaryView  = DefaultView(color: .white, raduis: 10)
    
    let subtotalLabel     = SeconderyTitleLabel(textAlignment: .left, fontSize: 16, fontColor: .black)
    let subtotal          = DefaultTitleLabel(textAlignment: .left, fontSize: 18, fontColor: .black)
    let subtotalLineView  = LineView(frame: .zero)
    
    let deliveryLabel     = SeconderyTitleLabel(textAlignment: .left, fontSize: 16, fontColor: .black)
    let delivery          = DefaultTitleLabel(textAlignment: .left, fontSize: 18, fontColor: .black)
    let deliveryLineView  = LineView(frame: .zero)

    let globalLeading: CGFloat  = 20
    let globalTrailing: CGFloat = -20
    
    
    let viewModel = CompleteOrderViewModel()
    let cartViewModel = CartViewModel()
    let connection = NetworkReachibility.shared


    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureHeaderView()
        configureTitleLabel()
        configureReturnBtn()
        configureScrollView()
        configureContainerView()
        configureShipmentLabel()
        configureShipmentView()
        configureShipmentimgView()
        configureshipmentTitle()
        configureshipmentDescription()
        configureItemsLabel()
        configureItemsView()
        configureShipmentNumLabel()
        configureDeliveryDate()
        configureItemsCollection()
        configurePaymentMethodLabel()
        configurePaymentView()
        configurePaymentButtons()
        configureOrderSummaryLabel()
        configureOrderSummaryView()
        configureSubTotalLabel()
        configureSubTotal()
        configureSubtotalLineView()

        configureDeliveryLabel()
        configureDelivery()
        configureDeliveryLineView()

        configureBottomView()
        configureGrandTotalLabel()
        configureCashLabel()
        configureCheckoutBtn()
        updateAddress()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
        configureView()
        updateAddress()
        connection.checkNetwork(target: self)

    }
    
    func updateAddress(){
        
        viewModel.updateTitleAddressClosure = {
            print("updateTitleAddressClosure")
            self.shipmentTitle.text = self.viewModel.getTitle()

        }

        viewModel.updateShipmentAddressClosure = {
            print("address should be updated")
            self.shipmentDescription.text = self.viewModel.getShipmentAddress()
        }
        
        
        viewModel.reloadCollectionViewClosure = {
            DispatchQueue.main.async {
                self.itemsCollection.reloadData()
            }
        }
        
        viewModel.updateCashPriceLabel = {
            DispatchQueue.main.async {
                self.subtotal.text      = "\(self.viewModel.totalPrice)"
                self.cashLabel.text     = "\(self.viewModel.totalPrice + 50 )"
            }
        }
        
    }

    private func configureView(){
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    private func configureHeaderView(){
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            headerView.heightAnchor.constraint(equalToConstant: 60)
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)

        ])
    }
    
    private func configureTitleLabel(){
        headerView.addSubview(titleLabel)
        titleLabel.text = "Complete your order".localized
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
//            usernameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10)
//            titleLabel.topAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    private func configureReturnBtn(){
        headerView.addSubview(returnBtn)
        returnBtn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            returnBtn.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
//            returnBtn.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            returnBtn.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            returnBtn.widthAnchor.constraint(equalToConstant: 30),
            returnBtn.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func dismissVC(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func configureScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)


        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureContainerView(){
        scrollView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            containerView.heightAnchor.constraint(equalToConstant: 1500),
            containerView.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ])
    }
    
    
    private func configureShipmentLabel(){
        containerView.addSubview(shipmentLabel)
        shipmentLabel.text = "Your Shipping Address".localized
        NSLayoutConstraint.activate([
            shipmentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            shipmentLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20)
        ])
    }
    
    private func configureShipmentView(){
        containerView.addSubview(shipmentView)
        NSLayoutConstraint.activate([
            shipmentView.topAnchor.constraint(equalTo: shipmentLabel.bottomAnchor, constant: 20),
            shipmentView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: globalLeading),
            shipmentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: globalTrailing)
        ])
    }
    
    private func configureShipmentimgView(){
        shipmentView.addSubview(shipmentimgView)
        shipmentimgView.image = UIImage(named: "location")?.withTintColor(UIColor(red: 23/255, green: 69/255, blue: 167/255, alpha: 1), renderingMode: .alwaysOriginal)
        shipmentimgView.contentMode = .center
        NSLayoutConstraint.activate([
//            shipmentimgView.topAnchor.constraint(equalTo: shipmentView.topAnchor, constant: 10),
            shipmentimgView.centerYAnchor.constraint(equalTo: shipmentView.centerYAnchor),
            shipmentimgView.leadingAnchor.constraint(equalTo: shipmentView.leadingAnchor, constant: 10),
            shipmentimgView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    private func configureshipmentTitle(){
        shipmentView.addSubview(shipmentTitle)
        shipmentTitle.text = "Title For Address"
        shipmentTitle.numberOfLines = 1
        NSLayoutConstraint.activate([
            shipmentTitle.topAnchor.constraint(equalTo: shipmentView.topAnchor, constant: 10),
            shipmentTitle.leadingAnchor.constraint(equalTo: shipmentimgView.trailingAnchor, constant: 10),
            shipmentTitle.trailingAnchor.constraint(equalTo: shipmentView.trailingAnchor, constant: globalTrailing)
        ])
    }

    
    private func configureshipmentDescription(){
        shipmentView.addSubview(shipmentDescription)
        shipmentDescription.text = "Shipment Address"
        shipmentDescription.numberOfLines = 2
        NSLayoutConstraint.activate([
            shipmentDescription.topAnchor.constraint(equalTo: shipmentTitle.bottomAnchor, constant: 3),
            shipmentDescription.leadingAnchor.constraint(equalTo: shipmentimgView.trailingAnchor, constant: 10),
            shipmentDescription.trailingAnchor.constraint(equalTo: shipmentView.trailingAnchor, constant: globalTrailing),
            shipmentDescription.bottomAnchor.constraint(equalTo: shipmentView.bottomAnchor, constant: -10)
        ])
    }

    
    private func configureItemsLabel(){
        containerView.addSubview(itemsLabel)
        itemsLabel.text = "products".localized
        NSLayoutConstraint.activate([
            itemsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            itemsLabel.topAnchor.constraint(equalTo: shipmentView.bottomAnchor, constant: 20)
        ])
    }
    
    private func configureItemsView(){
        containerView.addSubview(itemsView)
        NSLayoutConstraint.activate([
            itemsView.topAnchor.constraint(equalTo: itemsLabel.bottomAnchor, constant: 20),
            itemsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: globalLeading),
            itemsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: globalTrailing),
//            itemsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func configureShipmentNumLabel(){
        itemsView.addSubview(shipmentNumLabel)
        shipmentNumLabel.text = "shipmentNumber".localized
        NSLayoutConstraint.activate([
            shipmentNumLabel.topAnchor.constraint(equalTo: itemsView.topAnchor, constant: 10),
            shipmentNumLabel.leadingAnchor.constraint(equalTo: itemsView.leadingAnchor, constant: 10)
        ])
    }


    private func configureDeliveryDate(){
        itemsView.addSubview(deliveryDate)
        deliveryDate.text = "DeliveryDate".localized
        NSLayoutConstraint.activate([
            deliveryDate.topAnchor.constraint(equalTo: shipmentNumLabel.bottomAnchor, constant: 10),
            deliveryDate.leadingAnchor.constraint(equalTo: itemsView.leadingAnchor, constant: 10)
        ])
    }
    
    private func configureItemsCollection(){
        itemsCollection = UICollectionView(frame: .zero, collectionViewLayout: createHorizontalFlow())
        itemsCollection.register(CartItemCollectionViewCell.self, forCellWithReuseIdentifier: CartItemCollectionViewCell.reuseID)
        itemsView.addSubview(itemsCollection)
//        itemsCollection.backgroundColor = .green
        itemsCollection.translatesAutoresizingMaskIntoConstraints = false
        itemsCollection.dataSource = self
        itemsCollection.delegate   = self
        NSLayoutConstraint.activate([
            itemsCollection.topAnchor.constraint(equalTo: deliveryDate.bottomAnchor, constant: 10),
            itemsCollection.leadingAnchor.constraint(equalTo: itemsView.leadingAnchor),
            itemsCollection.trailingAnchor.constraint(equalTo: itemsView.trailingAnchor),
            itemsCollection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18),
            itemsCollection.bottomAnchor.constraint(equalTo: itemsView.bottomAnchor, constant: -10)
        ])
        
    }
    
    private func configurePaymentMethodLabel(){
        containerView.addSubview(paymentMethodLabel)
        paymentMethodLabel.text = "Available payment methods".localized
        NSLayoutConstraint.activate([
            paymentMethodLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            paymentMethodLabel.topAnchor.constraint(equalTo: itemsView.bottomAnchor, constant: 20)
        ])
    }
    
    private func configurePaymentView(){
        containerView.addSubview(paymentView)
        paymentView.addBorder(color: UIColor(red: 23/255, green: 69/255, blue: 167/255, alpha: 1))
        NSLayoutConstraint.activate([
            paymentView.topAnchor.constraint(equalTo: paymentMethodLabel.bottomAnchor, constant: 20),
            paymentView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: globalLeading),
            paymentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: globalTrailing),
            paymentView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configurePaymentButtons(){
        paymentView.addSubview(payOnDelivery)
        paymentView.addSubview(payOnline)
        payOnline.addTarget(self, action: #selector(updatePayonline), for: .touchUpInside)
        payOnDelivery.addTarget(self, action: #selector(updatePaymentBtn), for: .touchUpInside)
        payOnDelivery.backgroundColor = .green

        NSLayoutConstraint.activate([
            payOnDelivery.topAnchor.constraint(equalTo: paymentView.topAnchor, constant: 5),
            payOnDelivery.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 5),
            payOnDelivery.trailingAnchor.constraint(equalTo: paymentView.trailingAnchor, constant: -5),
            payOnDelivery.bottomAnchor.constraint(equalTo: paymentView.centerYAnchor, constant: -5),
            
            payOnline.topAnchor.constraint(equalTo: paymentView.centerYAnchor, constant: 5),
            payOnline.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 5),
            payOnline.trailingAnchor.constraint(equalTo: paymentView.trailingAnchor, constant: -5),
            payOnline.bottomAnchor.constraint(equalTo: paymentView.bottomAnchor, constant: -5)
        ])
    }
    
    @objc func updatePaymentBtn(){
        if payOnDelivery.backgroundColor != .green{
            payOnline.backgroundColor = .clear
            payOnDelivery.backgroundColor = .green
        }
    }
    
    @objc func updatePayonline(){
        if payOnline.backgroundColor != .green{

            payOnline.backgroundColor = .green
            payOnDelivery.backgroundColor = .clear
        }
    }

    
    private func configureOrderSummaryLabel(){
        containerView.addSubview(orderSummaryLabel)
        orderSummaryLabel.text = "orderSummary".localized
        NSLayoutConstraint.activate([
            orderSummaryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            orderSummaryLabel.topAnchor.constraint(equalTo: paymentView.bottomAnchor, constant: 20)
        ])
    }
    
    private func configureOrderSummaryView(){
        containerView.addSubview(orderSummaryView)
        NSLayoutConstraint.activate([
            orderSummaryView.topAnchor.constraint(equalTo: orderSummaryLabel.bottomAnchor, constant: 20),
            orderSummaryView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: globalLeading),
            orderSummaryView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: globalTrailing),
//            orderSummaryView.heightAnchor.constraint(equalToConstant: 150),
            orderSummaryView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -140),
        ])
    }
    
    private func configureSubTotalLabel(){
        orderSummaryView.addSubview(subtotalLabel)
        subtotalLabel.text = "Subtotal".localized
        NSLayoutConstraint.activate([
            subtotalLabel.topAnchor.constraint(equalTo: orderSummaryView.topAnchor, constant: 15),
            subtotalLabel.leadingAnchor.constraint(equalTo: orderSummaryView.leadingAnchor, constant: 10)
        ])
    }
    
    private func configureSubTotal(){
        orderSummaryView.addSubview(subtotal)
        subtotal.text = ""
        NSLayoutConstraint.activate([
            subtotal.centerYAnchor.constraint(equalTo: subtotalLabel.centerYAnchor),
            subtotal.trailingAnchor.constraint(equalTo: orderSummaryView.trailingAnchor, constant: -10)
        ])
    }
    
    private func configureSubtotalLineView(){
        orderSummaryView.addSubview(subtotalLineView)
        NSLayoutConstraint.activate([
            subtotalLineView.topAnchor.constraint(equalTo: subtotalLabel.bottomAnchor, constant: 4),
            subtotalLineView.leadingAnchor.constraint(equalTo: orderSummaryView.leadingAnchor,constant: 3),
            subtotalLineView.trailingAnchor.constraint(equalTo: orderSummaryView.trailingAnchor,constant: -3),
            subtotalLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    
    private func configureDeliveryLabel(){
        orderSummaryView.addSubview(deliveryLabel)
        deliveryLabel.text = "Delivery".localized
        NSLayoutConstraint.activate([
            deliveryLabel.topAnchor.constraint(equalTo: subtotalLineView.bottomAnchor, constant: 20),
            deliveryLabel.leadingAnchor.constraint(equalTo: orderSummaryView.leadingAnchor, constant: 10)
        ])
    }
    
    private func configureDelivery(){
        orderSummaryView.addSubview(delivery)
        delivery.text = "50"
        NSLayoutConstraint.activate([
            delivery.centerYAnchor.constraint(equalTo: deliveryLabel.centerYAnchor),
            delivery.trailingAnchor.constraint(equalTo: orderSummaryView.trailingAnchor, constant: -10)
        ])
    }
    
    private func configureDeliveryLineView(){
        orderSummaryView.addSubview(deliveryLineView)
        NSLayoutConstraint.activate([
            deliveryLineView.topAnchor.constraint(equalTo: deliveryLabel.bottomAnchor, constant: 4),
            deliveryLineView.leadingAnchor.constraint(equalTo: orderSummaryView.leadingAnchor, constant: 3),
            deliveryLineView.trailingAnchor.constraint(equalTo: orderSummaryView.trailingAnchor, constant: -3),
            deliveryLineView.heightAnchor.constraint(equalToConstant: 1),
            deliveryLineView.bottomAnchor.constraint(equalTo: orderSummaryView.bottomAnchor, constant: -10)
        ])
    }

    
    
    private func configureBottomView(){
        view.addSubview(bottomView)
        bottomView.addBorder(color: UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1))
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

//            bottomView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    
    
    private func configureGrandTotalLabel(){
        bottomView.addSubview(grandTotalLabel)
        grandTotalLabel.text = "Grand Total".localized
        NSLayoutConstraint.activate([
            grandTotalLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 30),
            grandTotalLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
        ])
    }
    
    private func configureCashLabel(){
        bottomView.addSubview(cashLabel)
        cashLabel.text = ""
        NSLayoutConstraint.activate([
            cashLabel.centerYAnchor.constraint(equalTo: grandTotalLabel.centerYAnchor),
//            cashLabel.leadingAnchor.constraint(equalTo: bottomView.centerXAnchor),
            cashLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10)
        ])
    }

    
    private func configureCheckoutBtn(){
        bottomView.addSubview(checkoutBtn)
        checkoutBtn.addTarget(self, action: #selector(placeOrder), for: .touchUpInside)
        NSLayoutConstraint.activate([
            checkoutBtn.topAnchor.constraint(equalTo: cashLabel.bottomAnchor, constant: 10),
            checkoutBtn.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            checkoutBtn.heightAnchor.constraint(equalToConstant: 50),
            checkoutBtn.bottomAnchor.constraint(equalTo: bottomView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            checkoutBtn.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10)
        ])
    }
    
    
    @objc func placeOrder(){
        
        CompleteOrderVC.presentAlertWithTwoActions(controller: self, title: "alert".localized, message: "Are you sure you want to buy".localized, style: .alert, actionTitle: "OK".localized) { action in
            self.performOrder()
        }
        
  
    }
    
 
    
    private func performOrder(){
        let id = UserDefaults.standard.value(forKey: "userId") as? Int ?? 0
        let userName = UserDefaults.standard.value(forKey: "userName") as? String ?? ""
        let orderCustomer = OrderCustomer(id: id, first_name: userName)
        let order = Order(line_items: cartViewModel.getCellViewModelArr(), customer: orderCustomer)
let testOrder = Order(line_items: [CartItemCellViewModel(name: "ADIDAS | CLASSIC BACKPACK", price: "70.00", imgUrl: "", id: "6747827109940", qty: "2", variant_id: "40002696282164")], customer: orderCustomer)
        let myOrder = APIOrder(order: testOrder)


        NetworkManager.shared.postOrder(order: myOrder) {(data, response, error) in
            if error != nil{
                print("error while posting order \(error!.localizedDescription)")
            }
            if let data = data{
                let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>
                print("json: \(json)")
                let returnedOrder = json["order"] as? Dictionary<String,Any>
                let confirmed = returnedOrder?["confirmed"] as? Int ?? 0
                if confirmed != 0 {
                    CoreDataManager.shared.deleteAllCart()
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)

                    }

                }
            }
        }
    }

    

}


extension CompleteOrderVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartItemCollectionViewCell.reuseID, for: indexPath) as! CartItemCollectionViewCell
        cell.configureCell(cellVM: viewModel.getCellViewModel(at: indexPath))
        return cell
    }
    
    
}




extension CompleteOrderVC: UICollectionViewDelegate{
    func createHorizontalFlow()-> UICollectionViewFlowLayout{
        let flowLayout = UICollectionViewFlowLayout()
        let availableWidth              = (view.frame.width - 15) / 5
        flowLayout.scrollDirection      = .horizontal
        let height                      = view.bounds.height * 0.15
        let availableHeight             = height
        flowLayout.itemSize             = CGSize(width: availableWidth, height: availableHeight)
        let padding: CGFloat            = 15
        flowLayout.sectionInset         = UIEdgeInsets(top: 5, left: padding, bottom: 5, right: padding)


        return flowLayout
        
    }
}
