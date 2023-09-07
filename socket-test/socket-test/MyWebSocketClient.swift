//
//  MyWebSocketClient.swift
//

import Foundation

final class MyWebSocketClient {
    private var webSocketTask: URLSessionWebSocketTask?
    var address: String?
    var port: String?
    let session: URLSession
    
    init() {
        self.session = URLSession(configuration: .default)
    }
    
    func setup() {
        address = ProcessInfo.processInfo.environment["ws_address"]
        port = ProcessInfo.processInfo.environment["ws_port"]
    }
    
    func connect() {
        let serverURL = URL(string: "ws://" + address! + ":" + port!)!
        
        webSocketTask = session.webSocketTask(with: serverURL)
        webSocketTask?.resume()
        
        receiveData()
    }
    
    func send(message: String) {
        let message = URLSessionWebSocketTask.Message.string(message)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("Error sending message: \(error)")
            }
        }
    }
    
    func receiveData() {
        webSocketTask?.receive { result in
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    print("Received message: \(text)")
                    if text == "ping" {
                        self.send(message: "pong")
                    }
                default:
                    break
                }
                
            case .failure(let error):
                print("WebSocket receive error: \(error)")
            }
        }
    }
    
    func disconnect() {
        webSocketTask?.cancel()
    }
}
