//
//  ViewController.swift
//  Toolbar+WKWebView
//
//  Created by 준수김 on 2022/07/19.
// https://cording-cossk3.tistory.com/129
// 영상이 자꾸 전체화면으로 뜰 떄는 WebView 자체의 Inline playback을 체크해준다. - https://sosoingkr.tistory.com/117


//MARK: 네비게이션 없애고 수정

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {

    //MARK: - 중복 리로드 방지 함수
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) { //reload 방지함수
        webView.reload()
    }
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var myWebView: WKWebView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrl()
        backButton.isHidden = true
        
    }
    
    //MARK: - 네비게이션 숨김
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - loadURL
    func loadUrl() {
        guard let url = URL(string: "https://atflee.com/") else { return }
        let request = URLRequest(url: url)
        myWebView.load(request)
        myWebView.uiDelegate = self
        myWebView.navigationDelegate = self
    }
    
    //MARK: - BackButton
    @IBAction func backButton(_ sender: Any) {
        if myWebView.canGoBack {
            backButton.isHidden = false
            myWebView.goBack()
        } else {
            backButton.isHidden = true
        }
        
        // 뒤로가기 버튼 메인페이지로 돌아가면 hide처리
        if myWebView.url! == URL(string: "https://m.atflee.com/#rldshow") || myWebView.url! == URL(string: "https://m.atflee.com/") {
            backButton.isHidden = true
        }

    }
    

}

extension ViewController:  WKNavigationDelegate {
    //MARK: - WKWebView에서 다른곳으로 이동할때마다 호출되는 메소드 (didFinish와 짝꿍)
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("show loading indicator ...")
        backButton.isHidden = !myWebView.canGoBack
        
        // 뒤로가기 버튼 메인페이지로 돌아가면 hide처리
        if myWebView.url! == URL(string: "https://m.atflee.com/#rldshow") || myWebView.url! == URL(string: "https://m.atflee.com/") {
            backButton.isHidden = true
        }
                        
    }

    //MARK: - WKWebView에서 다른곳으로 이동된 후에 호출되는 메소드 (didCommit와 짝꿍)
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("hide loading indicator ...")
    }
}

