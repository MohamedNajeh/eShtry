//
//  NetworkReachibility.swift
//  eShtry
//
//  Created by eslam mohamed on 18/03/2022.
//

import UIKit
import Reachability

class NetworkReachibility{
    let reachability = try? Reachability()
    
    static let shared = NetworkReachibility()
    private init(){}
    
    
    func checkNetwork(target:UIViewController){
        let noInterntView  = DefaultView(color: .white, raduis: 0)
        let noInterntStateImage = DefaultImageView(frame: .zero)
        
        guard let reachability = reachability else{return}
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                
            }else{
                print("Reachable via Cellular")
            }
            
            self.configureremoveNoInterntView(view: target.view, noInterntView: noInterntView, noInterntStateImage: noInterntStateImage)

        }
        reachability.whenUnreachable = { _ in
            let alert = UIAlertController(title: "No Connection!".localized,message:"Please Check Your Intenet Connection".localized,preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss".localized,style: .default, handler: nil))
            target.present(alert, animated: true, completion: nil)
            

            
            self.configureShowNoInterntView(view: target.view, noInterntView: noInterntView, noInterntStateImage: noInterntStateImage)
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    
    
    private func configureShowNoInterntView(view:UIView,noInterntView:DefaultView,noInterntStateImage:DefaultImageView){
        view.addSubview(noInterntView)
        noInterntView.addSubview(noInterntStateImage)
        noInterntStateImage.image       = UIImage(named: "noInternetConnection")
        noInterntStateImage.contentMode = .center
        
        NSLayoutConstraint.activate([
            noInterntView.topAnchor.constraint(equalTo: view.topAnchor),
            noInterntView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noInterntView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noInterntView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            noInterntStateImage.topAnchor.constraint(equalTo: noInterntView.topAnchor),
            noInterntStateImage.leadingAnchor.constraint(equalTo: noInterntView.leadingAnchor),
            noInterntStateImage.trailingAnchor.constraint(equalTo: noInterntView.trailingAnchor),
            noInterntStateImage.bottomAnchor.constraint(equalTo: noInterntView.bottomAnchor),
            
        ])
    }
    
    private func configureremoveNoInterntView(view:UIView,noInterntView:DefaultView,noInterntStateImage:DefaultImageView){
        noInterntView.removeFromSuperview()
    }

    
    
}
