//
//  ViewController.swift
//  AudioViewoPlayer
//
//  Created by Thanh Quach on 8/11/18.
//  Copyright © 2018 Thanh Quach. All rights reserved.
//

import UIKit
import VideoPlaybackKit
import AVFoundation

class ViewController: UIViewController {

    var player : AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        let videoType = VPKVideoType.remote(url: "https://cdn.24h.com.vn/upload/3-2018/videoclip/2018-08-11/1533934647-video_no_view_us_mun_lei_full.mp4", placeholderURLName: "https://cdn.24h.com.vn/upload/3-2018/videoclip/2018-08-11/1533934647-video_no_view_us_mun_lei_full.mp4")
//        let videoType = VPKVideoType.local(videoPathName: "test", fileType: "mov", placeholderImageName: "elon_1")
        VPKVideoPlaybackBuilder.vpk_buildVideoView(for: videoType, shouldAutoplay: true) { [weak self] (videoView) in
            guard let `self` = self else {return}

            self.view.addSubview(videoView)
            videoView.snp.makeConstraints({ (make) in
                make.height.equalTo(self.view.snp.height).dividedBy(2)
                make.centerY.equalToSuperview()
                make.left.right.equalTo(self.view)
            })
        }


    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.playSound("Duyen-Minh-Lo-Huong-Tram", type: "mp3")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func playSound(_ name: String, type: String = "mp3", afterDuration: TimeInterval = 0) {

        guard let path = Bundle.main.path(forResource: name, ofType:type)
            else {
                return
        }

        let url = URL(fileURLWithPath: path)

        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            self.player = sound
            player?.delegate = self
            sound.volume = 1 // 0 -> 1
            sound.numberOfLoops = 0

            sound.prepareToPlay()

            if afterDuration == 0 {
                sound.play()
            } else {
                sound.play(atTime: sound.deviceCurrentTime + afterDuration)
            }
        } catch {
            print("error loading file")
            // couldn't load file :(
        }
    }


}

extension ViewController: AVAudioPlayerDelegate {

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        playCompletion?(flag)
//        playCompletion = nil
        self.player = nil
    }

}
