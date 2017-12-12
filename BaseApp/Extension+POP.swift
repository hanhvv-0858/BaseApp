////
////  Extension+POP.swift
////  BaseApp
////
////  Created by nguyen.duy.phong on 11/23/17.
////  Copyright © 2017 Phong Nguyen. All rights reserved.
////
//
//import UIKit
//import SnapKit
//
//enum LoadingType {
//    case pullToRefresh
//    case top
//    case center
//    case loadMore
//    case full
//}
//
//enum PositionLoading {
//    case top
//    case center
//}
//
//class LoadingView: UIView {
//
//    var tagObject: String?
//
//    private var loadingIndicatorView: UIActivityIndicatorView?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.initDefault()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        self.initDefault()
//    }
//
//    private func initDefault() {
//        loadingIndicatorView = UIActivityIndicatorView()
//        loadingIndicatorView?.hidesWhenStopped = true
//        loadingIndicatorView?.activityIndicatorViewStyle = .gray
//        self.addSubview(loadingIndicatorView!)
//        self.bringSubview(toFront: loadingIndicatorView!)
//
//        loadingIndicatorView?.snp.makeConstraints { (make) in
//            make.center.equalTo(self)
//        }
//        self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//    }
//
//    func startAnimating() {
//        loadingIndicatorView?.startAnimating()
//    }
//}
//
//protocol Loadingable {
//
//    var isLoadingIndicator: Bool { get }
//
//    var loadingView: LoadingView { get }
//
//    func showLoadingIndicator(inView: UIView?, position: PositionLoading, offset: Float)
//
//    func hideLoadingIndicator()
//}
//
//
//extension Loadingable {
//
//    var isLoadingIndicator: Bool {
//        if let _ = loadingView.superview {
//            return true
//        }
//        return false
//    }
//
//    func hideLoadingIndicator() {
//        loadingView.removeFromSuperview()
//    }
//}
//
//extension Loadingable where Self: UIViewController {
//
//    var loadingView: LoadingView {
//
//        if let loadingView = self.view.subviews.reversed().first(where: {$0 is LoadingView }) as? LoadingView {
//            return loadingView
//        }
//
//        // create new
//        let loadingView = LoadingView()
//        return loadingView
//    }
//
//    func showLoadingIndicator(inView: UIView?, position: PositionLoading, offset: Float) {
//        self.hideLoadingIndicator()
//        guard let _view = inView else {
//            return
//        }
//        let _loadingView = loadingView
//        let frame = _loadingView.frame
//        self.view.addSubview(_loadingView)
//        self.view.bringSubview(toFront: _loadingView)
//        _loadingView.snp.makeConstraints { (make) in
//            switch position {
//            case .top:
//                make.top.equalTo(_view.snp.top).offset(offset)
//            case .center:
//                make.centerY.equalTo(_view.snp.centerY).offset(offset)
//            }
//            make.centerX.equalTo(_view.snp.centerX)
//            make.height.equalTo(frame.size.height)
//            make.width.equalTo(frame.size.width)
//        }
//        _loadingView.startAnimating()
//
//    }
//}
//
//extension Loadingable where Self: UIView {
//
//    var loadingView: LoadingView {
//
//        if let loadingView = self.subviews.reversed().first(where: {$0 is LoadingView }) as? LoadingView {
//            return loadingView
//        }
//
//        // create new
//        let loadingView = LoadingView()
//        return loadingView
//    }
//
//    func showLoadingIndicator(position: PositionLoading, offset: Float) {
//        self.hideLoadingIndicator()
//
//        let _loadingView = loadingView
//        let frame = _loadingView.frame
//        self.addSubview(_loadingView)
//        self.bringSubview(toFront: _loadingView)
//        _loadingView.snp.makeConstraints { (make) in
//            switch position {
//            case .top:
//                make.top.equalTo(self.snp.top).offset(offset)
//            case .center:
//                make.centerY.equalTo(self.snp.centerY).offset(offset)
//            }
//            make.centerX.equalTo(self.snp.centerX)
//            make.height.equalTo(frame.size.height)
//            make.width.equalTo(frame.size.width)
//        }
//        _loadingView.startAnimating()
//
//    }
//}

