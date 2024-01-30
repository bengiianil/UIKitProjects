//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Bengi Anıl on 1.08.2022.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "train", ofType: "m4v")!))
        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        player.play()
    }
}

