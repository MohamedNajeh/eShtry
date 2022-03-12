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
    
    let checkoutBtn       = DefaultButton(btnTitle: "CHECKOUT ALL", titleColor: .white, backgroundColor: UIColor(red: 255/255, green: 0, blue: 5/255, alpha: 1), raduis: 10)
    
    
    
    
    var cartItemsTableView: UITableView!
    let refreshControl  = UIRefreshControl()
    let tableViewFooter = DefaultView(color: .clear, raduis: 0)


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
        


        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()

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
            headerView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureUsernameLabel(){
        headerView.addSubview(usernameLabel)
        usernameLabel.text = "eslams's Basket"
        NSLayoutConstraint.activate([
            usernameLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
//            usernameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
//            usernameLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10)
            usernameLabel.topAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.topAnchor, constant: 10)
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
//        locationImage.image = UIImage(named: "location")
        locationImage.image = UIImage(systemName: "location.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .small))?.withTintColor(.white, renderingMode: .alwaysOriginal)
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
//        locationDownImage.image = UIImage(named: "right-arrow6")
        locationDownImage.image = UIImage(systemName: "arrow.down.app.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .small))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        locationDownImage.contentMode = .center

        NSLayoutConstraint.activate([
            locationDownImage.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: -5),
            locationDownImage.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 5),
            locationDownImage.bottomAnchor.constraint(equalTo: locationView.bottomAnchor, constant: -5),
            locationDownImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureLocationTitle(){
        locationView.addSubview(locationLabel)
        locationLabel.text = "configureLocationTitle()configureLocationTitle()configureLocationTitle()configureLocationTitle()configureLocationTitle()"
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
    }

    
    private func configureTableViewFooter(){
        tableViewFooter.frame.size.height = 100
        tableViewFooter.translatesAutoresizingMaskIntoConstraints = true
        let titleLabel = SeconderyTitleLabel(textAlignment: .center, fontSize: 18, fontColor: .black)
        titleLabel.numberOfLines = 0
        titleLabel.text  = "Available payment methods"
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
            titleLabel.topAnchor.constraint(equalTo: tableViewFooter.topAnchor, constant: 15),
            
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
        cartItemsTableView = UITableView(frame: .zero, style: .plain)
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
        cartItemsTableView.reloadData()
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
        subTotalLabel.text = "Subtotal"
        NSLayoutConstraint.activate([
            subTotalLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 30),
            subTotalLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
        ])
    }
    
    private func configureNumberOfItemsLabel(){
        bottomView.addSubview(numberOfItems)
        numberOfItems.text = "( 10 items)"
        NSLayoutConstraint.activate([
            numberOfItems.centerYAnchor.constraint(equalTo: subTotalLabel.centerYAnchor),
            numberOfItems.leadingAnchor.constraint(equalTo: subTotalLabel.trailingAnchor, constant: 10),
        ])
    }
    
    private func configureCashLabel(){
        bottomView.addSubview(cashLabel)
        cashLabel.text = "EGP 999.999.999.9"
        NSLayoutConstraint.activate([
            cashLabel.centerYAnchor.constraint(equalTo: subTotalLabel.centerYAnchor),
//            cashLabel.leadingAnchor.constraint(equalTo: bottomView.centerXAnchor),
            cashLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10)
        ])
    }
    
    
    private func configureDescriptionLabel(){
        bottomView.addSubview(descriptionLabel)
        descriptionLabel.text = "descriptionLabeldescriptionLabeldescriptionLabeldescriptionLabel"
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: subTotalLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 40)
        ])
    }
    
    
    private func configureCheckoutBtn(){
        bottomView.addSubview(checkoutBtn)
        NSLayoutConstraint.activate([
            checkoutBtn.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            checkoutBtn.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            checkoutBtn.heightAnchor.constraint(equalToConstant: 50),
            checkoutBtn.bottomAnchor.constraint(equalTo: bottomView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            checkoutBtn.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10)
        ])
    }
    
    
    private func configureHeaderViewForSection(section:Int)->UIView{
        let view = DefaultView(color: .white, raduis: 5)
        view.translatesAutoresizingMaskIntoConstraints = true
        let sectionLabel = DefaultTitleLabel(textAlignment: .center, fontSize: 18, fontColor: .black)
        sectionLabel.text = "section name \(section)"
        view.addSubview(sectionLabel)
        NSLayoutConstraint.activate([
            sectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            sectionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            

        ])
        return view
    }
    
    
    @objc func minusBtnTapped(sender:UIButton){
        print("minus Btn ")
        let buttonTag = sender.tag
        print(buttonTag)
    }

        

}


extension CartVC: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTableViewCell.reuseID, for: indexPath) as! CartItemTableViewCell
//        cell.minusBtn.tag = indexPath.row + 1
        cell.minusBtn.addTarget(self, action: #selector(minusBtnTapped(sender:)), for: .touchUpInside)
//        cell.plusBtn.addTarget(self, action:#selector(minusBtnTapped(sender:)), for: .touchUpInside)
//        cell.plusBtn.tag = indexPath.row + 2
        
//        let minusBtn: UIButton = cell.viewWithTag(5) as! UIButton
//        minusBtn.setTitle("\(indexPath.row)", for: .normal)
//        minusBtn.tag = indexPath.row
//        print(minusBtn.tag)
//        minusBtn.addTarget(self, action: #selector(minusBtnTapped(sender:)), for: .touchUpInside)

        return cell
    }
    
    
}


extension CartVC: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return configureHeaderViewForSection(section: section)
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("push product VC")
    }
    
    
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section Index\(section)"
//    }
}
