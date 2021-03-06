//
//  CartVC.swift
//  eShtry
//
//  Created by eslam mohamed on 10/03/2022.
//

import UIKit

class CartVC: UIViewController {
    
    let headerView        = DefaultView(color: UIColor(red: 23/255, green: 69/255, blue: 167/255, alpha: 1), raduis: 0)
    let usernameLabel     = DefaultTitleLabel(textAlignment: .center, fontSize: 18, fontColor: .white)
    
    let locationView      = DefaultView(color: UIColor(red: 17/255, green: 52/255, blue: 125/255, alpha: 1), raduis: 0)
    let locationImage     = DefaultImageView(frame: .zero)
    let locationLabel     = SeconderyTitleLabel(textAlignment: .left, fontSize: 16, fontColor: .white)
    let locationDownImage = DefaultImageView(frame: .zero)
    let locationBtn       = DefaultButton(btnTitle: "", titleColor: .clear, backgroundColor: .clear, raduis: 0)
    
    let bottomView        = TopRoundView(raduis: 15,color: .white)
    let subTotalLabel     = DefaultTitleLabel(textAlignment: .left, fontSize: 18, fontColor: .black)
    let numberOfItems     = SeconderyTitleLabel(textAlignment: .left, fontSize: 15, fontColor: .black)
    let cashLabel         = DefaultTitleLabel(textAlignment: .left, fontSize: 18, fontColor: .black)
    let descriptionLabel  = SeconderyTitleLabel(textAlignment: .left, fontSize: 15, fontColor: .black)
    
    let checkoutBtn       = DefaultButton(btnTitle: "CHECKOUT ALL".localized, titleColor: .white, backgroundColor: UIColor(red: 255/255, green: 0, blue: 5/255, alpha: 1), raduis: 10)
    
    let locationChoiceView = TopRoundView(raduis: 15, color: .white)
    
    
    
    var cartItemsTableView: UITableView!
    let refreshControl  = UIRefreshControl()
    let tableViewFooter = DefaultView(color: .clear, raduis: 0)
    var cellIndex       = 0
    
    let hideLocationBtn = ImageButton(typeOfBtn: .exitBtn)
    let addressLabel    = SeconderyTitleLabel(textAlignment: .center, fontSize: 25, fontColor: .black)
    let addNewAddressBtn = DefaultButton(btnTitle: "Add New Address".localized, titleColor: UIColor(red: 37/255, green: 67/255, blue: 150/255, alpha: 1), backgroundColor: .clear, raduis: 0)
    var addressCollectionView: UICollectionView!
    
    let networkShared = NetworkManager.shared
    
    var ordersArr = [Orders]()
    
    let viewModel        = CartViewModel()
    let addressViewModel = AddressViewModel()
    var addressIndexPath:IndexPath!
    var addressToSave:AddressCellViewModel!
    
    var cartItemPrice = 0
    
    let emptyStateView  = DefaultView(color: .white, raduis: 0)
    let emptyStateImage = DefaultImageView(frame: .zero)
    let loginImage      = DefaultImageView(frame: .zero)
    
    let connection = NetworkReachibility.shared
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHeaderView()
        configureUsernameLabel()
        configureLocationView()
        configureLocationImage()
        configureLocationDownImage()
        configureLocationTitle()
        configureLoactionBtn()
        configureBottomView()
        configureBottomView()
        configureSubTotalLabel()
        configureNumberOfItemsLabel()
        configureCashLabel()
        configureDescriptionLabel()
        configureCheckoutBtn()
        
        configureTableViewFooter()
        
        configureCartItemsTableView()
        configureRefreshForTable()
        
        configureLocationChoiceView()
        configureExitBtnForAddressView()
        configureAddressLabel()
        configureAddNewAddressBtn()
        configureAddressCollectionView()
        configureShowEmptyStateView()
        
        
        testApi()
        updateViewWithLoadingView()
        updateLocationViewWithAddress()
        updateViewWithEmotyStateView()
        
        
    }
    
    func updateViewWithLoadingView(){
        
        viewModel.relodTableViewClosure = {
            print("reload table view executed")
            self.cartItemsTableView.isHidden = false
            self.emptyStateView.isHidden     = true
            self.cartItemsTableView.reloadData()
        }
        
        viewModel.bindToShowLoadingToView = {
            print("show Loading")
        }
        viewModel.bindToHideLoadingToView = {
            print("hide Loading")

        }
        
        viewModel.updateCashPriceLabel = {
            DispatchQueue.main.async {
                self.cashLabel.text      = "\(self.viewModel.totalPrice)"
                self.numberOfItems.text  = "( \(self.viewModel.numberOfCells) \("Items".localized) )"
            }
        }
        
        
        
    }
    
    func updateViewWithEmotyStateView(){
        viewModel.showEmptyStateClosure = {
            DispatchQueue.main.async {
                self.cartItemsTableView.isHidden = true
                self.emptyStateView.isHidden     = false
                
            }
        }
    }
    
    func updateLocationViewWithAddress(){
        addressViewModel.relodCollectionViewClosure = {
            DispatchQueue.main.async {
                self.addressCollectionView.reloadData()
            }
        }
    }
    
    func testApi(){
//        networkShared.getDataFromApi(urlString: "https://f36da23eb91a2fd4cba11b9a30ff124f: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@jets-ismailia.myshopify.com/admin/api/2022-01/products.json", baseModel: ProductsRoot.self) { result in
//            switch result {
//            case .success(let products):
//                print(products.products?.count)
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//
//        networkShared.getDataFromApi(urlString: "https://f36da23eb91a2fd4cba11b9a30ff124f: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@jets-ismailia.myshopify.com/admin/api/2022-01/smart_collections.json", baseModel: SmartCollectionRoot.self) { result  in
//            switch result{
//            case .success(let result):
//                print("collection count \(result.smart_collections?.count)")
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//
//        networkShared.getDataFromApi(urlString: "https://f36da23eb91a2fd4cba11b9a30ff124f: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@jets-ismailia.myshopify.com/admin/api/2022-01/customers/5740683427887/addresses.json", baseModel: AddressesRoot.self) { result  in
//            switch result{
//            case .success(let result):
//                print("Address count \(result.addresses?.count)")
//            case .failure(let error):
//                print(error)
//            }
//        }
//        
//        
//
//        let body: [String: Any] = [
//            "customer": [
//              "first_name": "eslam",
//              "last_name": "mohamed",
//              "email": "eslam.lastnameson@example.com",
//              "phone": "+01009452129",
//              "verified_email": true,
//              "addresses": [
//                  "address1": "123 Oak St",
//                  "city": "Ottawa",
//                  "province": "ON",
//                  "phone": "555-1212",
//                  "zip": "123 ABC",
//                  "last_name": "Lastnameson",
//                  "first_name": "Mother",
//                  "country": "CA"
//
//              ]],
//              "send_email_invite": true
//          ]
//
//
//        networkShared.postDataToApi(urlString: "https://f36da23eb91a2fd4cba11b9a30ff124f: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@jets-ismailia.myshopify.com/admin/api/2022-01/customers.json", httpMethod: .post, body: body, baseModel: CustomarRoot.self) { result in
//            switch result{
//            case .success(let customer):
//                print("succeed")
//            case .failure(let error):
//                print(error)
//            }
//        }
//        
//        
//        
//        networkShared.getDataFromApi(urlString: orders, baseModel: OrdersRoot.self) { result in
//            switch result{
//            case .success(let orders):
//                guard let orders = orders.orders else{return}
//                self.ordersArr = orders
////                NetworkManager.shared.order = orders
//                print("order arr count \(self.ordersArr.count)")
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
        viewModel.fetchCartItems()
        addressViewModel.fetchDataFromApi()
        connection.checkNetwork(target: self)
        
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
    
    private func configureUsernameLabel(){
        headerView.addSubview(usernameLabel)
        usernameLabel.text = "eslams's \("Basket".localized)"
        NSLayoutConstraint.activate([
            usernameLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            //            usernameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
                        usernameLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10)
//            usernameLabel.topAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    private func configureLocationView(){
        view.addSubview(locationView)
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            locationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationView.heightAnchor.constraint(equalToConstant: 40)
            
            
        ])
    }
    
    
    private func configureLocationImage(){
        locationView.addSubview(locationImage)
        locationImage.image = UIImage(named: "location")?.withTintColor(.white, renderingMode: .alwaysOriginal)

        locationImage.contentMode = .center
        NSLayoutConstraint.activate([
            locationImage.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 5),
            locationImage.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 5),
            locationImage.bottomAnchor.constraint(equalTo: locationView.bottomAnchor, constant: -5),
            locationImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    private func configureLocationDownImage(){
        locationView.addSubview(locationDownImage)
                locationDownImage.image = UIImage(named: "downArrow")?.withTintColor(.white, renderingMode: .alwaysOriginal)
//        locationDownImage.image = UIImage(systemName: "arrow.down.app.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .small))?.withTintColor(.white, renderingMode: .alwaysOriginal)
//        locationDownImage.contentMode = .center
        
        
        NSLayoutConstraint.activate([
            locationDownImage.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: -5),
            locationDownImage.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 5),
            locationDownImage.bottomAnchor.constraint(equalTo: locationView.bottomAnchor, constant: -5),
            locationDownImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureLocationTitle(){
        locationView.addSubview(locationLabel)
        locationLabel.text = ""
        NSLayoutConstraint.activate([
            locationLabel.centerYAnchor.constraint(equalTo: locationView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 10),
            locationLabel.trailingAnchor.constraint(equalTo: locationDownImage.leadingAnchor, constant: -10)
        ])
    }
    
    private func configureLoactionBtn(){
        locationView.addSubview(locationBtn)
        locationBtn.addTarget(self, action: #selector(locationBtnAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            locationBtn.topAnchor.constraint(equalTo: locationView.topAnchor),
            locationBtn.leadingAnchor.constraint(equalTo: locationView.leadingAnchor),
            locationBtn.trailingAnchor.constraint(equalTo: locationView.trailingAnchor),
            locationBtn.bottomAnchor.constraint(equalTo: locationView.bottomAnchor),
        ])
    }
    
    @objc func locationBtnAction(){
        print("loactionBtnTapped")
        updateLocationChoiceView()
        
    }
    
    private func updateLocationChoiceView(){
        if locationChoiceView.isHidden == true{
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn],
                           animations: {
                self.locationChoiceView.center.y -= self.locationChoiceView.bounds.height
                self.locationChoiceView.layoutIfNeeded()
            }, completion: nil)
            self.locationChoiceView.isHidden = false
            
        }else{
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear],
                           animations: {
                self.locationChoiceView.center.y += self.locationChoiceView.bounds.height
                self.locationChoiceView.layoutIfNeeded()
                
            },  completion: {(_ completed: Bool) -> Void in
                self.locationChoiceView.isHidden = true
            })
        }

    }
    
    private func configureLocationChoiceView(){
        view.addSubview(locationChoiceView)
        locationChoiceView.isHidden = true
        locationChoiceView.addBorder(color: UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1))

        NSLayoutConstraint.activate([
            locationChoiceView.topAnchor.constraint(equalTo: view.bottomAnchor),
            locationChoiceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationChoiceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationChoiceView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func configureExitBtnForAddressView(){
        locationChoiceView.addSubview(hideLocationBtn)
        hideLocationBtn.addTarget(self, action: #selector(locationBtnAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            hideLocationBtn.topAnchor.constraint(equalTo: locationChoiceView.topAnchor,constant: 10),
            hideLocationBtn.trailingAnchor.constraint(equalTo: locationChoiceView.trailingAnchor, constant: -10),
            hideLocationBtn.widthAnchor.constraint(equalToConstant: 25),
            hideLocationBtn.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func configureAddressLabel(){
        locationChoiceView.addSubview(addressLabel)
        addressLabel.text = "address".localized
        NSLayoutConstraint.activate([
            addressLabel.centerYAnchor.constraint(equalTo: hideLocationBtn.centerYAnchor),
            addressLabel.centerXAnchor.constraint(equalTo: locationChoiceView.centerXAnchor)
        ])
    }
    
    private func configureAddNewAddressBtn(){
        locationChoiceView.addSubview(addNewAddressBtn)
        addNewAddressBtn.addTarget(self, action: #selector(pushAddNewAddressVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            addNewAddressBtn.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
            addNewAddressBtn.leadingAnchor.constraint(equalTo: locationChoiceView.leadingAnchor, constant: 10),
            addNewAddressBtn.trailingAnchor.constraint(equalTo: locationChoiceView.centerXAnchor, constant: 10)
            
        ])
        
    }
    
    @objc func pushAddNewAddressVC(){
        
//        let storyboard = UIStoryboard(name: "meVC", bundle: .main)
//        let addressVC  = storyboard.instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
//        addressVC.modalPresentationStyle = .automatic
//        self.present(addressVC, animated: true, completion: nil)
        
        let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first
        let tabBarController = keyWindow?.rootViewController as! UITabBarController
        tabBarController.selectedIndex = 4
        self.dismiss(animated: true, completion: {
            self.navigationController?.popToRootViewController(animated: false)
            self.updateLocationChoiceView()
        })

    }
    
    private func configureAddressCollectionView(){
        addressCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
        addressCollectionView.register(AddressCollectionViewCell.self, forCellWithReuseIdentifier: AddressCollectionViewCell.reuseID)
        locationChoiceView.addSubview(addressCollectionView)
        addressCollectionView.backgroundColor = .clear
        addressCollectionView.delegate   = self
        addressCollectionView.dataSource = self
//        addressCollectionView.isPagingEnabled = true
        addressCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressCollectionView.topAnchor.constraint(equalTo: addNewAddressBtn.bottomAnchor, constant: 10),
            addressCollectionView.leadingAnchor.constraint(equalTo: locationChoiceView.leadingAnchor),
            addressCollectionView.trailingAnchor.constraint(equalTo: locationChoiceView.trailingAnchor),
            addressCollectionView.bottomAnchor.constraint(equalTo: locationChoiceView.bottomAnchor, constant: -10),
        ])
    }
    
    private func configureTableViewFooter(){
        tableViewFooter.frame.size.height = 100
        tableViewFooter.translatesAutoresizingMaskIntoConstraints = true
        let titleLabel = SeconderyTitleLabel(textAlignment: .center, fontSize: 18, fontColor: .black)
        titleLabel.numberOfLines = 0
        titleLabel.text  = "Available payment methods".localized
        tableViewFooter.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //        stackView.backgroundColor = .green
        
        let imageView0 = UIImageView()
        imageView0.image = UIImage(named: "visa")
        let imageView1 = UIImageView()
        imageView1.image = UIImage(named: "masterCard")
        let imageView2 = UIImageView()
        imageView2.image = UIImage(named: "meeza")
        let imageView3 = UIImageView()
        imageView3.image = UIImage(named: "cashOnDeleviry")
        tableViewFooter.addSubview(stackView)
        stackView.addArrangedSubview(imageView0)
        stackView.addArrangedSubview(imageView1)
        stackView.addArrangedSubview(imageView2)
        stackView.addArrangedSubview(imageView3)
        
        stackView.distribution = .fillEqually
        stackView.alignment    = .fill
        stackView.spacing      = 25
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: tableViewFooter.centerXAnchor),
            //            titleLabel.centerYAnchor.constraint(equalTo: tableViewFooter.centerYAnchor)
            titleLabel.topAnchor.constraint(equalTo: tableViewFooter.topAnchor),
            
            //            stackView.leadingAnchor.constraint(equalTo: tableViewFooter.leadingAnchor, constant: 20),
            //            stackView.trailingAnchor.constraint(equalTo: tableViewFooter.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.heightAnchor.constraint(equalToConstant: 30),
            stackView.centerXAnchor.constraint(equalTo: tableViewFooter.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 250)
            //            stackView.bottomAnchor.constraint(equalTo: tableViewFooter.bottomAnchor)
        ])
    }
    
    
    private func configureCartItemsTableView(){
        cartItemsTableView = UITableView(frame: .zero, style: .grouped)
        cartItemsTableView.register(CartItemTableViewCell.self, forCellReuseIdentifier: CartItemTableViewCell.reuseID)
        view.addSubview(cartItemsTableView)
        cartItemsTableView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        cartItemsTableView.translatesAutoresizingMaskIntoConstraints = false
        cartItemsTableView.separatorStyle = .none
        cartItemsTableView.dataSource = self
        cartItemsTableView.delegate   = self
        //        cartItemsTableView.allowsSelection = false
        cartItemsTableView.tableFooterView = tableViewFooter
        
        NSLayoutConstraint.activate([
            cartItemsTableView.topAnchor.constraint(equalTo: locationView.bottomAnchor),
            cartItemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cartItemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            cartItemsTableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
        ])
    }
    
    private func configureRefreshForTable(){
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        cartItemsTableView.addSubview(refreshControl)
        
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        print("refresh")
        viewModel.fetchCartItems()
        refreshControl.endRefreshing()
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
    
    private func configureSubTotalLabel(){
        bottomView.addSubview(subTotalLabel)
        subTotalLabel.text = "Subtotal".localized
        NSLayoutConstraint.activate([
            subTotalLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 30),
            subTotalLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
        ])
    }
    
    private func configureNumberOfItemsLabel(){
        bottomView.addSubview(numberOfItems)
        numberOfItems.text = ""
        NSLayoutConstraint.activate([
            numberOfItems.centerYAnchor.constraint(equalTo: subTotalLabel.centerYAnchor),
            numberOfItems.leadingAnchor.constraint(equalTo: subTotalLabel.trailingAnchor, constant: 10),
        ])
    }
    
    private func configureCashLabel(){
        bottomView.addSubview(cashLabel)
//        cashLabel.text = "\(viewModel.cartItemPrices)"
        NSLayoutConstraint.activate([
            cashLabel.centerYAnchor.constraint(equalTo: subTotalLabel.centerYAnchor),
            //            cashLabel.leadingAnchor.constraint(equalTo: bottomView.centerXAnchor),
            cashLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10)
        ])
    }
    
    
    private func configureDescriptionLabel(){
        bottomView.addSubview(descriptionLabel)
        descriptionLabel.text = "prices include tax".localized
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: subTotalLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 40)
        ])
    }
    
    
    private func configureCheckoutBtn(){
        bottomView.addSubview(checkoutBtn)
        checkoutBtn.addTarget(self, action: #selector(pushCompleteCartVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            checkoutBtn.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            checkoutBtn.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            checkoutBtn.heightAnchor.constraint(equalToConstant: 50),
            checkoutBtn.bottomAnchor.constraint(equalTo: bottomView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            checkoutBtn.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10)
        ])
    }
    
    @objc func pushCompleteCartVC(){
        
        if addressViewModel.numberOfCells > 0 {
            let completeCartVC = CompleteOrderVC()
            self.navigationController?.pushViewController(completeCartVC, animated: true)
        }else{
            CartVC.presentAlert(controller: self, title: "Sorry".localized, message: "Please press location button above to add address".localized, style: .alert, actionTitle: "OK".localized) { action in
                self.dismiss(animated: true)
            }
        }
        
    }
    
    
    private func configureHeaderViewForSection(section:Int)->UIView{
        let view = TopRoundView(raduis: 10, color: .clear)
        view.translatesAutoresizingMaskIntoConstraints = true
        let backgrounView = DefaultView(color: .white, raduis: 10)
        view.translatesAutoresizingMaskIntoConstraints = true
        let sectionLabel = SeconderyTitleLabel(textAlignment: .center, fontSize: 18, fontColor: .black)
        sectionLabel.text = "products".localized
        backgrounView.addSubview(sectionLabel)
        view.addSubview(backgrounView)
        NSLayoutConstraint.activate([
            backgrounView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5),
            backgrounView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgrounView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgrounView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            sectionLabel.leadingAnchor.constraint(equalTo: backgrounView.leadingAnchor, constant: 15),
            sectionLabel.topAnchor.constraint(equalTo: backgrounView.topAnchor, constant: 5),
//            sectionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
            
        ])
        return view
    }
    
    
    private func configureFooterViewForSection(section:Int)->UIView{
        let view = DefaultView(color: .clear, raduis: 0)
        let backgrounView = DefaultView(color: .white, raduis: 10)
        view.translatesAutoresizingMaskIntoConstraints = true
        let sectionLabel = SeconderyTitleLabel(textAlignment: .center, fontSize: 18, fontColor: .black)
        sectionLabel.text = "\("Subtotal".localized)  \(viewModel.totalPrice)"
        backgrounView.addSubview(sectionLabel)
        view.addSubview(backgrounView)
        NSLayoutConstraint.activate([
            backgrounView.topAnchor.constraint(equalTo: view.topAnchor, constant: -5),
            backgrounView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgrounView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgrounView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            sectionLabel.leadingAnchor.constraint(equalTo: backgrounView.leadingAnchor, constant: 15),
            sectionLabel.topAnchor.constraint(equalTo: backgrounView.topAnchor, constant: 5),
//            sectionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
            
        ])
        return view
    }
    
    
    @objc func minusBtnTapped(sender:ImageButton){
        print("minus Btn ")
        print("indexPath is \(sender.indexPath)")
        let cell = cartItemsTableView.cellForRow(at: IndexPath(row: sender.indexPath.row, section: sender.indexPath.section)) as! CartItemTableViewCell
        if cell.amountLabel.text != "1"{
            let qty = String((Int(cell.amountLabel.text ?? "0") ?? 0) - 1)
            cell.amountLabel.text = qty
            let cartToBeUpdated = viewModel.getCellViewModel(at: sender.indexPath)
            
            let item = CartItem(name: cartToBeUpdated.name, price: cartToBeUpdated.price, imgUrl: cartToBeUpdated.imgUrl,id:cartToBeUpdated.id,qty: qty,variant_id: cartToBeUpdated.variant_id)
            CoreDataManager.shared.insertCartItem(cartItem: item,qtyTypeProcess: .subtraction)
            
            guard let price = Int(item.price) else {return}
            var  cash = Int(self.cashLabel.text!)!
            cash -= price
            self.cashLabel.text = "\(cash)"
            let imageIcon = UIImage(systemName: "minus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .small))?.withTintColor(.red, renderingMode: .alwaysOriginal)
            cell.minusBtn.setImage(imageIcon, for: .normal)
            performAnimationForCartButtons(button: cell.minusBtn)
        }else{
            CartVC.presentAlertWithTwoActions(controller: self, title: "alert".localized, message: "Are you sure you want to delete item".localized, style: .alert, actionTitle: "OK".localized) { action in
                CartVC.showToast(controller: self, message: "item deleted successfully".localized, seconds: 1)
                self.viewModel.deleteItem(at: sender.indexPath)
                
            }
        }
        
        
        print("minus is : \(cell.amountLabel.text!)")
        let qty = String((Int(cell.amountLabel.text ?? "0") ?? 0) )
        if qty == "1"{
            let imageIcon = UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .small))?.withTintColor(.red, renderingMode: .alwaysOriginal)
            cell.minusBtn.setImage(imageIcon, for: .normal)
        }
        
    }
    
    @objc func plusBtnTapped(sender:ImageButton){
        print("plus Btn ")
        print("indexPath is \(sender.indexPath)")
        let cell = cartItemsTableView.cellForRow(at: IndexPath(row: sender.indexPath.row, section: sender.indexPath.section)) as! CartItemTableViewCell
        let qty = String((Int(cell.amountLabel.text ?? "0") ?? 0) + 1)
        cell.amountLabel.text = qty
        print("plus is : \(qty)")
        let cartToBeUpdated = viewModel.getCellViewModel(at: sender.indexPath)
        
        let item = CartItem(name: cartToBeUpdated.name, price: cartToBeUpdated.price, imgUrl: cartToBeUpdated.imgUrl,id:cartToBeUpdated.id,qty: qty,variant_id: cartToBeUpdated.variant_id)
        CoreDataManager.shared.insertCartItem(cartItem: item,qtyTypeProcess: .addition)
        
        guard let price = Int(item.price) else {return}
        var  cash = Int(self.cashLabel.text!)!
        cash += price
        self.cashLabel.text = "\(cash)"
        let imageIcon = UIImage(systemName: "minus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .small))?.withTintColor(.red, renderingMode: .alwaysOriginal)
        cell.minusBtn.setImage(imageIcon, for: .normal)
        performAnimationForCartButtons(button: cell.plusBtn)
        
        
        
    }
    
    
    
    private func performAnimationForCartButtons(button:ImageButton){
    
    UIView.animate(withDuration: 0.4, delay: 0,
           usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
           options: [], animations: {
        
        button.transform =
               CGAffineTransform(scaleX: 2.0, y: 2.0)
        button.transform =
               CGAffineTransform(scaleX: 1.0, y: 1.0)
    }) { _ in

    }

   

}

    
    private func configureShowEmptyStateView(){
        view.addSubview(emptyStateView)
        emptyStateView.addSubview(emptyStateImage)
        emptyStateImage.image       = UIImage(named: "emptyCart")
        emptyStateImage.contentMode = .center
        emptyStateView.isHidden = true
        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyStateImage.topAnchor.constraint(equalTo: emptyStateView.topAnchor),
            emptyStateImage.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor),
            emptyStateImage.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor),
            emptyStateImage.bottomAnchor.constraint(equalTo: emptyStateView.bottomAnchor),
            
        ])
    }
    
    
    
}


extension CartVC: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTableViewCell.reuseID, for: indexPath) as! CartItemTableViewCell
        cell.minusBtn.indexPath = indexPath
        cell.plusBtn.indexPath  = indexPath
        cell.minusBtn.addTarget(self, action: #selector(minusBtnTapped(sender:)), for: .touchUpInside)
        cell.plusBtn.addTarget(self, action:#selector(plusBtnTapped(sender:)), for: .touchUpInside)
        
        //        let minusBtn: UIButton = cell.viewWithTag(5) as! UIButton
        //        minusBtn.setTitle("\(indexPath.row)", for: .normal)
        //        minusBtn.tag = indexPath.row
        //        print(minusBtn.tag)
        //        minusBtn.addTarget(self, action: #selector(minusBtnTapped(sender:)), for: .touchUpInside)
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.configureCell(cell: cellVM)
        return cell
    }
    
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //    }
    
}


extension CartVC: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return configureHeaderViewForSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return configureFooterViewForSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("push product VC")
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 150
    //    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return "Section Index\(section)"
    //    }
}


extension CartVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addressViewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddressCollectionViewCell.reuseID, for: indexPath) as! AddressCollectionViewCell
        cell.configure(cellVM: addressViewModel.getCellViewModel(at: indexPath))
        return cell
    }
    
    
}

extension CartVC:UICollectionViewDelegate{
    
    private func createFlowLayout()-> UICollectionViewLayout{
        let width                       = view.bounds.width
//        let padding: CGFloat            = 15
//        let minimumItemSpacing: CGFloat = 15
        let availableWidth              = width //- (padding * 2) //- minimumItemSpacing
        let itemSize                    = availableWidth
        let height                      = view.bounds.height * 0.28
        let availableHeight             = height
        let itemHeight                  = availableHeight
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        flowLayout.itemSize             = CGSize(width: itemSize, height: itemHeight)
        flowLayout.scrollDirection      = .vertical
        flowLayout.minimumLineSpacing   = 0
        
        return flowLayout
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AddressCollectionViewCell
        self.updateLocationChoiceView()
        self.locationLabel.text = cell.address.text
        self.addressIndexPath = indexPath
        self.addressToSave = AddressCellViewModel(addressTitle: cell.addressTitle.text!, owner: cell.owner.text!, phoneNumber: cell.phoneNumber.text!, cityCountry: "egypt", address: cell.address.text!, isDefault: "isDefault")
        CoreDataManager.shared.saveAddress(address:addressToSave )
    }
    
}
