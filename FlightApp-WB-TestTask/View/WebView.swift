//
//  WebView.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 18.10.2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

