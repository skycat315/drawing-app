//
//  ViewController.swift
//  Lesson9_PaintApp
//
//  Created by Yoko Kuroshima on 2021/10/11.
//

import UIKit

class ViewController: UIViewController {
    
    // startボタン
    @IBOutlet weak var startButton: UIButton!
    
    // 各画像
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var icecreamImage: UIImageView!
    @IBOutlet weak var swirlImage: UIImageView!
    @IBOutlet weak var grapesImage: UIImageView!
    @IBOutlet weak var fishImage: UIImageView!
    
    // AppDelegateのインスタンスを作成
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // お絵描き途中の絵
    var drawingInProgress: UIImage!
    
    // スタートボタンを押すとPaintページに遷移
    @IBAction func startButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景の色を薄い黄色にする
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 0.7, alpha: 1)
        
        // STARTボタン
        self.startButton.backgroundColor = .orange
        self.startButton.layer.borderWidth = 2
        self.startButton.layer.borderColor = UIColor.white.cgColor
        self.startButton.titleLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 22)
        
        // 角を丸くする
        self.startButton.layer.cornerRadius = 10
        // ボタンに影をつける
        // 影の大きさ
        self.startButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        // 影の薄さ
        self.startButton.layer.shadowOpacity = 0.5
        // 影の丸み
        self.startButton.layer.shadowRadius = 10
        // 影の色
        self.startButton.layer.shadowColor = UIColor.gray.cgColor
        
    }
}
