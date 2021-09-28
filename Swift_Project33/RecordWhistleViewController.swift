//
//  RecordWhistleViewController.swift
//  Swift_Project33
//
//  Created by Alex 6.1 on 9/28/21.
//

import UIKit
import AVFoundation

class RecordWhistleViewController: UIViewController {
    
    var stackView: UIStackView!
    var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var whistleRecorder: AVAudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Record Your Whistle"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Record", style: .plain, target: nil, action: nil)
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        self.loadFailUI()
                    } // else if
                } // DispatchQueue
                
            } //recordingSession
        } catch {
            self.loadFailUI()
        } // catch
    }
    
    func loadRecordingUI() {
        
    } // loadRecordingUI
    
    func loadFailUI() {
        
    } // loadFailUI
    
    override func loadView() {
        view = UIView()
        
        view.backgroundColor = .gray
        
        stackView = UIStackView()
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = .center
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}
