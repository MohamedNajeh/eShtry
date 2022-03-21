//
//  UIViewController+Extension.swift
//  eShtry
//
//  Created by eslam mohamed on 17/03/2022.
//


import UIKit

fileprivate var containerView: DefaultView!

extension UIViewController{
    
    
    static func showToast(controller: UIViewController, message: String, seconds: Double){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 0.8)
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "Almarai-Bold", size: 20)!,NSAttributedString.Key.foregroundColor: UIColor(red: 0.0/255.0, green: 129.0/255.0, blue: 138.0/255.0, alpha: 1.0)]
        let titleString = NSAttributedString(string: message, attributes: titleAttributes)
        
        alert.setValue(titleString, forKey: "attributedTitle")
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    
    static func presentAlert(controller: UIViewController,title:String, message: String,style:UIAlertController.Style,actionTitle:String,action:@escaping (_ action:UIAlertAction)->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle:style )
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: action))
         controller.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    func showLoadingView(){
        containerView = DefaultView(color: .darkGray, raduis: 15)
        view.addSubview(containerView)
        containerView.alpha           = 0
        UIView.animate(withDuration: 0.25) {containerView.alpha = 0.4}
        let activityIndecator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndecator)
        activityIndecator.color = .black
        activityIndecator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            activityIndecator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndecator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        activityIndecator.startAnimating()
    }
    
    func removeLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
}

extension UIViewController {
func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
    if #available(iOS 13.0, *) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: tintColor]
        navBarAppearance.backgroundColor = backgoundColor

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.title = title
        

    } else {
        // Fallback on earlier versions
        navigationController?.navigationBar.barTintColor = backgoundColor
        navigationController?.navigationBar.tintColor = tintColor
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = title
    }
}}
