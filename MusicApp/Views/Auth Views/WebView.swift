//
//  WebView.swift
//  MusicApp
//
//  Created by Lalit Vinde on 18/09/23.
//

import Foundation
import SwiftUI
import WebKit

struct WebView : UIViewRepresentable{

    @Binding var isPresented:Bool
    @Binding var isLoading:Bool
    var url:URL?
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        if let url = url{
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {


    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    class Coordinator : NSObject, WKNavigationDelegate{
        @Injected(\.authService) var authService : AuthServicable
        @Environment(\.colorScheme) var colorScheme

        let parent: WebView
        
        init(parent: WebView) {
            self.parent = parent
        }
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
            
            guard let url = webView.url else {
                return
            }
            
            guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value
                else {
                    return
                }
            
            Task{
                await authService.exchangeCodeForToken(code:code)
                await MainActor.run{
                    parent.isPresented = false
                }
            }
            
           
        }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
            parent.isLoading = false
            
        }
        
    }
    
    typealias UIViewType = WKWebView
    
    
}
