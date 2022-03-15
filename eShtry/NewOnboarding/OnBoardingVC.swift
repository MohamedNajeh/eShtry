//
//  ViewController.swift
//  Caregory
//
//  Created by Mahmoud Ghoneim on 3/11/22.
//

import UIKit
import AVFoundation
import Combine

class OnBoardingVC: UIViewController {
    
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var getStartedbutton: UIButton!
    
    private var player     : AVPlayer?
    private var playerlayer: AVPlayerLayer?
    private let notificationCenter = NotificationCenter.default
    private var appEventSubscribers = [AnyCancellable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        observeAppEvents()
        setupPlayerlayerIfNeeded()
        restartVideo()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeAppEventSubscribers()
        removePlayer()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerlayer?.frame = view.frame
    }
    
    
    private func configureUI(){
        getStartedbutton.layer.cornerRadius = 28
        getStartedbutton.layer.borderWidth = 1
        getStartedbutton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        darkView.backgroundColor = UIColor.init(white: 0.1, alpha: 0.4)
        
    }
    
    private func buildPlayer()->AVPlayer?{
        guard let filePath = Bundle.main.path(forResource: "backgroundVideo", ofType: "mp4") else{ return nil}
        let url = URL(fileURLWithPath: filePath)
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.isMuted = true
        return player
    }
    
    
    private func buildPlayerlayer() -> AVPlayerLayer?{
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        return layer
    }
    
    
    private func playVideo(){
        player?.play()
    }
    
    
    private func restartVideo(){
        player?.seek(to: .zero)
        playVideo()
    }
    
    
    private func pauseVideo(){
        player?.pause()
        
    }
    
    private func setupPlayerlayerIfNeeded(){
        player = buildPlayer()
        playerlayer = buildPlayerlayer()
        
        if let layer = playerlayer , view.layer.sublayers?.contains(layer) == false{
            view.layer.insertSublayer(layer, at: 0)
        }
        
    }
    
    
    private func removePlayer(){
        player?.pause()
        player = nil
        playerlayer?.removeFromSuperlayer()
        playerlayer = nil
    }
    
    private func observeAppEvents(){
        notificationCenter.publisher(for: .AVPlayerItemDidPlayToEndTime).sink {[weak self] _ in
            guard let self = self else { return }
            self.restartVideo()
        }.store(in: &appEventSubscribers)
        
        notificationCenter.publisher(for: UIApplication.willResignActiveNotification).sink { [weak self] _ in
            guard let self = self else { return }
            self.pauseVideo()
        }.store(in: &appEventSubscribers)
        
        
        notificationCenter.publisher(for: UIApplication.didBecomeActiveNotification).sink { [weak self] _ in
            guard let self = self else { return }
            self.playVideo()
        }.store(in: &appEventSubscribers)
        
    }
    
    
    private func removeAppEventSubscribers(){
        appEventSubscribers.forEach { (canelable) in
            canelable.cancel()
        }
    }
    
    
    
    
    @IBAction func getStartedButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "firstTimeToUseApplication")
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryVC" ) as! CategoryVC
//        self.navigationController?.pushViewController(vc, animated: true)
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate!.window?.rootViewController = sceneDelegate?.createTabBarController()
    }
    
}

