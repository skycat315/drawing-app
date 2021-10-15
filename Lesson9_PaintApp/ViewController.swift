//
//  ViewController.swift
//  Lesson9_PaintApp
//
//  Created by Yoko Kuroshima on 2021/10/11.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var icecreamImage: UIImageView!
    @IBOutlet weak var swirlImage: UIImageView!
    @IBOutlet weak var grapesImage: UIImageView!
    @IBOutlet weak var fishImage: UIImageView!
    
    //スタートボタンを押すとPaintページに遷移
    @IBAction func startButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景の色を薄い黄色にする
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 0.7, alpha: 1)
        
        //STARTボタン
        startButton.backgroundColor = .orange
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.white.cgColor
        //角を丸くする
        startButton.layer.cornerRadius = 10
        //ボタンに影をつける
        //影の大きさ
        startButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        //影の薄さ
        startButton.layer.shadowOpacity = 0.5
        //影の丸み
        startButton.layer.shadowRadius = 10
        //影の色
        startButton.layer.shadowColor = UIColor.gray.cgColor
        
        //絵の影を設定
        catImage.layer.shadowOffset = CGSize(width: 5, height: 0)
        catImage.layer.shadowOpacity = 1
        catImage.layer.shadowRadius = 5
        catImage.layer.shadowColor = UIColor.black.cgColor
        
        icecreamImage.layer.shadowOffset = CGSize(width: -5, height: 0)
        icecreamImage.layer.shadowOpacity = 1
        icecreamImage.layer.shadowRadius = 5
        icecreamImage.layer.shadowColor = UIColor.black.cgColor
        
        swirlImage.layer.shadowOffset = CGSize(width: -5, height: 0)
        swirlImage.layer.shadowOpacity = 1
        swirlImage.layer.shadowRadius = 5
        swirlImage.layer.shadowColor = UIColor.black.cgColor
        
        grapesImage.layer.shadowOffset = CGSize(width: 5, height: 0)
        grapesImage.layer.shadowOpacity = 1
        grapesImage.layer.shadowRadius = 5
        grapesImage.layer.shadowColor = UIColor.black.cgColor
        
        fishImage.layer.shadowOffset = CGSize(width: 5, height: 0)
        fishImage.layer.shadowOpacity = 1
        fishImage.layer.shadowRadius = 5
        fishImage.layer.shadowColor = UIColor.black.cgColor
        
        
    }
    //backボタンを押すとトップ画面に戻る
    @IBAction func onClickBack(_segue: UIStoryboardSegue) {
        
    }
    
}
