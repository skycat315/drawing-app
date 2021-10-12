//
//  ViewController.swift
//  Lesson9_PaintApp
//
//  Created by Yoko Kuroshima on 2021/10/11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var canvasImageView: UIImageView!
    
    //色選択ボタン
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var skyblueButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var brownButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    
    //操作ボタン
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    //絵を描く黒板部分
    var canvas = UIImageView()
    //スクリーン画面のサイズを取得
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    //線の色を白に設定
    var lineColor = UIColor.white
    //曲線を扱うために定義
    var bezierPath: UIBezierPath!
    //ここまでに描いた絵
    var lastDrawImage: UIImage!
    //タッチした回数を定義
    var currentDrawNumber = 0
    //画像を保存するための配列を宣言
    var savedImageArray: Array<UIImage> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //背景を茶色にする
        view.backgroundColor = UIColor.brown
        canvas.frame = CGRect(x:20, y:40, width: screenWidth - 40,  height: screenHeight - 140)
        //canvasは黒板の色にする
        canvas.backgroundColor = UIColor(red: 0, green: 0.3, blue: 0.1, alpha: 1)
        view.addSubview(canvas)
        
        //各色のボタンを装飾
        whiteButton.backgroundColor = .white
        whiteButton.layer.borderWidth = 2
        whiteButton.layer.borderColor = UIColor.black.cgColor
        
        redButton.backgroundColor = .red
        redButton.layer.borderWidth = 2
        redButton.layer.borderColor = UIColor.black.cgColor
        
        orangeButton.backgroundColor = .orange
        orangeButton.layer.borderWidth = 2
        orangeButton.layer.borderColor = UIColor.black.cgColor
        
        yellowButton.backgroundColor = .yellow
        yellowButton.layer.borderWidth = 2
        yellowButton.layer.borderColor = UIColor.black.cgColor
        
        greenButton.backgroundColor = .green
        greenButton.layer.borderWidth = 2
        greenButton.layer.borderColor = UIColor.black.cgColor
        
        skyblueButton.backgroundColor = UIColor(red: 0, green: 0.9294, blue: 1.0, alpha: 1)
        skyblueButton.layer.borderWidth = 2
        skyblueButton.layer.borderColor = UIColor.black.cgColor
        
        blueButton.backgroundColor = .blue
        blueButton.layer.borderWidth = 2
        blueButton.layer.borderColor = UIColor.black.cgColor
        
        purpleButton.backgroundColor = .purple
        purpleButton.layer.borderWidth = 2
        purpleButton.layer.borderColor = UIColor.black.cgColor
        
        brownButton.backgroundColor = UIColor(red: 0.3294, green: 0.1725, blue: 0, alpha:1)
        brownButton.layer.borderWidth = 2
        brownButton.layer.borderColor = UIColor.black.cgColor
        
        blackButton.backgroundColor = .black
        
        //操作ボタンを装飾
        undoButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        undoButton.backgroundColor = UIColor(red: 1, green: 0.9, blue: 0.6, alpha: 1)
        undoButton.layer.borderWidth = 2
        undoButton.layer.borderColor = UIColor.white.cgColor
        undoButton.layer.cornerRadius = 20
        
        clearButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        clearButton.backgroundColor = UIColor(red: 0.8, green: 1, blue: 1, alpha: 1)
        clearButton.layer.borderWidth = 2
        clearButton.layer.borderColor = UIColor.white.cgColor
        clearButton.layer.cornerRadius = 20
        
        saveButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        saveButton.backgroundColor = UIColor(red: 1, green: 0.9, blue: 1, alpha: 1)
        saveButton.layer.borderWidth = 2
        saveButton.layer.borderColor = UIColor.white.cgColor
        saveButton.layer.cornerRadius = 20
    }
    
    //タッチ時の処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        //現在の座標を取得
        let currentPoint: CGPoint = touchEvent.location(in: canvas)
        bezierPath = UIBezierPath()
        bezierPath.lineWidth = 4.0
        //始点を現在の位置に設定
        bezierPath.move(to: currentPoint)
    }
    
    //ドラッグ中の処理
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil {
            return
        }
        let touchEvent = touches.first!
        let currentPoint: CGPoint = touchEvent.location(in: canvas)
        bezierPath.addLine(to: currentPoint)
        drawLine(path: bezierPath)
    }
    
    //指を離した時の処理
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil {
            return
        }
        let touchEvent = touches.first!
        let currentPoint: CGPoint = touchEvent.location(in: canvas)
        bezierPath.addLine(to: currentPoint)
        drawLine(path: bezierPath)
        //ここまでに描いた絵を保存
        lastDrawImage = canvas.image
        /*undo処理
         //タッチの回数を保存
         currentDrawNumber += 1
         savedImageArray.append(self.canvas.image!)
         //タッチの回数と配列の数に矛盾がないか確認
         while currentDrawNumber != savedImageArray.count - 1 {
         savedImageArray.removeLast()
         }
         */
    }
    
    //描画時の処理
    func drawLine(path: UIBezierPath) {
        //非表示の描画領域を生成
        UIGraphicsBeginImageContext(canvas.frame.size)
        //これまでに描いた絵があれば描写
        if lastDrawImage != nil {
            lastDrawImage.draw(at: CGPoint(x:0, y:0))
        }
        lineColor.setStroke()
        path.stroke()
        //UIImageViewのCanvasに画像を写す
        self.canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        //描画を終了
        UIGraphicsEndImageContext()
        
    }
    
    @IBAction func selectRed(_ sender: Any) {
        //線の色を赤色に変更
        lineColor = UIColor.red
        lineColor.setStroke()
    }
    
    @IBAction func selectOrange(_ sender: Any) {
        //線の色をオレンジ色に変更
        lineColor = UIColor.orange
        lineColor.setStroke()
    }
    
    @IBAction func selectYellow(_ sender: Any) {
        //線の色を黄色に変更
        lineColor = UIColor.yellow
        lineColor.setStroke()
    }
    
    @IBAction func selectGreen(_ sender: Any) {
        //線の色を緑色に変更
        lineColor = UIColor.green
        lineColor.setStroke()
    }
    
    @IBAction func selectSkyblue(_ sender: Any) {
        //線の色を水色に変更
        lineColor = UIColor(red: 0, green: 0.9294, blue: 1.0, alpha: 1)
        lineColor.setStroke()
    }
    
    @IBAction func selectBlue(_ sender: Any) {
        //線の色を青色に変更
        lineColor = UIColor.blue
        lineColor.setStroke()
    }
    
    @IBAction func selectPurple(_ sender: Any) {
        //線の色を紫色に変更
        lineColor = UIColor.purple
        lineColor.setStroke()
    }
    
    @IBAction func selectBrown(_ sender: Any) {
        //線の色を茶色に変更
        lineColor = UIColor(red: 0.3294, green: 0.1725, blue: 0, alpha:1)
        lineColor.setStroke()
    }
    
    @IBAction func selectBlack(_ sender: Any) {
        //線の色を黒色に変更
        lineColor = UIColor.black
        lineColor.setStroke()
    }
    
    
    
    
    
    
    
    @IBAction func onClickSave(_ sender: Any) {
    }
    
    /*undo処理
     @IBAction func onClickUndo(_ sender: Any) {
     //currentDrawNumberが0の時はundoを押しても何も起きない
     if currentDrawNumber <= 0 {
     return
     }
     self.canvas.image = savedImageArray[currentDrawNumber]
     currentDrawNumber -= 1
     }
     */
    
    @IBAction func onClickClear(_ sender: Any) {
        //何かが書かれていたら削除して黒板を最初の状態に戻す
        if lastDrawImage != nil {
            lastDrawImage = nil
            canvas.image = nil
        }
        
    }
}
