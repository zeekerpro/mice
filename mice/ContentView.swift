//
//  ContentView.swift
//  macgpt
//
//  Created by zeeker # on 8/24/23.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State private var urlString = "https://chat.openai.com/" // 替换为你想要打开的网页的URL

    var body: some View {
        WebView(urlString: $urlString)
        //Text("hello world")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WebView: View {
    @Binding var urlString: String
    var body: some View {
        WebViewContainer(urlString: $urlString)
    }
}

struct WebViewContainer: NSViewRepresentable {
    @Binding var urlString: String

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            nsView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewContainer

        init(_ parent: WebViewContainer) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // 在这里可以处理加载完成后的操作
        }
    }
}
