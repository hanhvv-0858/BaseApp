//
//  VideoLaucher.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 4/11/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    fileprivate var player: AVPlayer?
    fileprivate var urlString: String?
    
    let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge).with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.startAnimating()
    }
    
    let pausePlayButton = UIButton(type: .system).with {
        let image = UIImage(named: "pause")
        $0.setImage(image, for: UIControlState())
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .white
        $0.isHidden = true
        $0.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
    }
    
    let controlsContainerView = UIView().with {
        $0.backgroundColor = UIColor(white: 0, alpha: 1)
    }
    
    let videoLengthLabel = UILabel().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "00:00"
        $0.textColor = UIColor.white
        $0.font = UIFont.boldSystemFont(ofSize: 13)
        $0.textAlignment = .right
    }
    
    let currentTimeLabel = UILabel().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        $0.text = "00:00"
        $0.textColor = UIColor.white
        $0.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    let videoSilder = UISlider().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.minimumTrackTintColor = .red
        $0.maximumTrackTintColor = .white
        $0.setThumbImage(UIImage(named: "thumb"), for: UIControlState())
        $0.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
    }
    
    fileprivate var isPlaying = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayerView()
        setupGradientLayer()
        setupUI()
    }
    
    @objc fileprivate func handlePause() {
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: UIControlState())
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: UIControlState())
        }
        isPlaying = !isPlaying
    }
    
    fileprivate func setupUI() {
        backgroundColor = .black
        // controlsContainerView
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        // aiv
        controlsContainerView.addSubview(aiv)
        aiv.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
        aiv.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
        //pausePlayButton
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        //videoLengthLabel
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: controlsContainerView.rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor, constant: -2).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        //currentTimeLabel
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        //videoSilder
        controlsContainerView.addSubview(videoSilder)
        videoSilder.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor, constant: 0).isActive = true
        videoSilder.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor, constant: 0).isActive = true
        videoSilder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSilder.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    fileprivate func setupPlayerView() {
        if let urlString = urlString, let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            // track player progress
            
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
                let minutesString = String(format: "%02d", Int(seconds / 60))
                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                
                //lets move the slider thumb
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.videoSilder.value = Float(seconds / durationSeconds)
                }
                
            })
        }
    }
    
    @objc fileprivate func handleSliderChange() {
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSilder.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                //perhaps do something later here
            })
        }

    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
}

class VideoLaucher: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func showVideoPlayer() {
        print("Showing video player animation....")
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame = CGRect(x: keyWindow.frame.width, y: keyWindow.frame.height, width: 0, height: 0)
            
            //16 x 9 is the aspect ratio of all HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                view.frame = keyWindow.frame
                
            }, completion: { (completedAnimation) in
                //maybe we'll do something here later...
                //UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}
