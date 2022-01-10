//
//  PaintViewController.swift
//  Lesson9_PaintApp
//
//  Created by Yoko Kuroshima on 2021/10/14.
//

import UIKit
import AVFoundation // 音声を使用するため

class PaintViewController: UIViewController {
    
    @IBOutlet weak var canvasImageView: UIImageView!
    
    // 色選択ボタン
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var pinkButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var skyblueButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var brownButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    
    // 操作ボタン
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    // AppDelegateのインスタンスを作成
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // 絵を描く黒板部分
    var canvas = UIImageView()
    // スクリーン画面のサイズを取得
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    // 開始時の色を黒に設定
    var lineColor = UIColor.black
    // 曲線を扱うために定義
    var bezierPath: UIBezierPath!
    // ここまでに描いた絵
    var lastDrawImage:UIImage!
    // タッチした回数を定義
    var currentTouchNumber = 0
    // 画像を保存するための配列を宣言
    var savedImageArray:[UIImage] = []
    
    // AVAudioPlayerのインスタンスを宣言
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景を茶色にする
        view.backgroundColor = UIColor.brown
        canvas.frame = CGRect(x:20, y:40, width: screenWidth - 40,  height: screenHeight - 140)
        // canvasは黒板の色にする
        canvas.backgroundColor = UIColor(red: 0, green: 0.3, blue: 0.1, alpha: 1)
        canvas.layer.cornerRadius = 10
        view.addSubview(canvas)
        
        // 開始時は黒のペンが選択されているので、黒色ボタンの背景を暗くする
        blackButton.alpha = 0.5
        
        // 各色のボタンを装飾
        redButton.backgroundColor = .red
        redButton.layer.borderWidth = 2
        redButton.layer.borderColor = UIColor.black.cgColor
        
        pinkButton.backgroundColor = UIColor(red: 1, green: 0.4, blue: 1, alpha: 1)
        pinkButton.layer.borderWidth = 2
        pinkButton.layer.borderColor = UIColor.black.cgColor
        
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
        
        // 操作ボタンを装飾
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
        
        homeButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        homeButton.backgroundColor = UIColor(red: 0.8, green: 1, blue: 0.6, alpha: 1)
        homeButton.layer.borderWidth = 2
        homeButton.layer.borderColor = UIColor.white.cgColor
        homeButton.layer.cornerRadius = 20
        
        // 作業中の絵がある場合はその絵を開く
        if appDelegate.draftImage != nil {
            self.canvas.image = appDelegate.draftImage
            lastDrawImage = self.canvas.image
            // 動作確認用
            print("2. AppDelegate → PaintViewControllerにデータを戻しました。")
        } else {
            return
        }
        
    }
    
    // タッチ時の処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        // 現在の座標を取得
        let currentPoint: CGPoint = touchEvent.location(in: canvas)
        bezierPath = UIBezierPath()
        bezierPath.lineWidth = 4.0
        // 始点を現在の位置に設定
        bezierPath.move(to: currentPoint)
    }
    
    // ドラッグ中の処理
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil {
            return
        }
        let touchEvent = touches.first!
        let currentPoint: CGPoint = touchEvent.location(in: canvas)
        bezierPath.addLine(to: currentPoint)
        drawLine(path: bezierPath)
    }
    
    // 指を離した時の処理
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil {
            return
        }
        let touchEvent = touches.first!
        let currentPoint: CGPoint = touchEvent.location(in: canvas)
        bezierPath.addLine(to: currentPoint)
        drawLine(path: bezierPath)
        // ここまでに描いた絵を保存
        lastDrawImage = self.canvas.image
        // データをAppDelegateの変数に代入
        appDelegate.draftImage = lastDrawImage
        // タッチの回数を保存
        currentTouchNumber += 1
        savedImageArray.append(self.canvas.image!)
        // onClickUndoを押したときにtouchesEndedの処理を拾わないようにする
        bezierPath = nil
        
        // 動作確認用
        print("touchesEnded")
        print("1. PaintViewController → AppDelegateに保存しました")
    }
    
    // 描画時の処理
    func drawLine(path: UIBezierPath) {
        // 非表示の描画領域を生成
        UIGraphicsBeginImageContext(canvas.frame.size)
        // これまでに描いた絵があれば描写
        if lastDrawImage != nil {
            lastDrawImage.draw(at: CGPoint(x:0, y:0))
        }
        lineColor.setStroke()
        path.stroke()
        // UIImageViewのCanvasに画像を写す
        self.canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        // 描画を終了
        UIGraphicsEndImageContext()
        
    }
    
    
    @IBAction func selectRed(_ sender: Any) {
        // 全ての色ボタンの背景をデフォルトにする
        resetButton()
        // 線の色を赤色に変更
        lineColor = UIColor.red
        lineColor.setStroke()
        // 押下されたらボタンの背景を暗くする
        redButton.alpha = 0.5
    }
    
    
    @IBAction func selectPink(_ sender: Any) {
        resetButton()
        // 線の色をピンク色に変更
        lineColor = UIColor(red: 1, green: 0.4, blue: 1, alpha: 1)
        lineColor.setStroke()
        pinkButton.alpha = 0.5
    }
    
    @IBAction func selectOrange(_ sender: Any) {
        resetButton()
        // 線の色をオレンジ色に変更
        lineColor = UIColor.orange
        lineColor.setStroke()
        orangeButton.alpha = 0.5
    }
    
    @IBAction func selectYellow(_ sender: Any) {
        resetButton()
        // 線の色を黄色に変更
        lineColor = UIColor.yellow
        lineColor.setStroke()
        yellowButton.alpha = 0.5
    }
    
    @IBAction func selectGreen(_ sender: Any) {
        resetButton()
        // 線の色を緑色に変更
        lineColor = UIColor.green
        lineColor.setStroke()
        greenButton.alpha = 0.5
    }
    
    @IBAction func selectSkyblue(_ sender: Any) {
        resetButton()
        // 線の色を水色に変更
        lineColor = UIColor(red: 0, green: 0.9294, blue: 1.0, alpha: 1)
        lineColor.setStroke()
        skyblueButton.alpha = 0.5
    }
    
    @IBAction func selectBlue(_ sender: Any) {
        resetButton()
        // 線の色を青色に変更
        lineColor = UIColor.blue
        lineColor.setStroke()
        blueButton.alpha = 0.5
    }
    
    @IBAction func selectPurple(_ sender: Any) {
        resetButton()
        // 線の色を紫色に変更
        lineColor = UIColor.purple
        lineColor.setStroke()
        purpleButton.alpha = 0.5
    }
    
    @IBAction func selectBrown(_ sender: Any) {
        resetButton()
        // 線の色を茶色に変更
        lineColor = UIColor(red: 0.3294, green: 0.1725, blue: 0, alpha:1)
        lineColor.setStroke()
        brownButton.alpha = 0.5
    }
    
    @IBAction func selectBlack(_ sender: Any) {
        resetButton()
        // 線の色を黒色に変更
        lineColor = UIColor.black
        lineColor.setStroke()
        blackButton.alpha = 0.5
    }
    
    // 押下されたボタンの背景を暗くする
    func resetButton() {
        redButton.alpha = 1.0
        pinkButton.alpha = 1.0
        orangeButton.alpha = 1.0
        yellowButton.alpha = 1.0
        greenButton.alpha = 1.0
        skyblueButton.alpha = 1.0
        blueButton.alpha = 1.0
        purpleButton.alpha = 1.0
        brownButton.alpha = 1.0
        blackButton.alpha = 1.0
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        // 何も書かれていない画像は保存しない
        if lastDrawImage == nil {
            return
        } else {
            // 保存した場合はサウンドを再生
            if let soundURL = Bundle.main.url(forResource: "saveSound", withExtension: "mp3") {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    audioPlayer?.play()
                } catch {
                    print("Sound error")
                }
            }
            // saveボタンを押したら絵をカメラロールに保存する
            UIImageWriteToSavedPhotosAlbum(self.canvas.image!, self, nil, nil)
        }
    }
    
    @IBAction func onClickUndo(_ sender: Any) {
        if currentTouchNumber <= 1 {
            // 初期状態に戻す
            currentTouchNumber = 0
            self.canvas.image = nil
            lastDrawImage = nil
            savedImageArray.removeAll()
        } else {
            // 1つ前の画像に戻す、不要になった画像は削除する
            currentTouchNumber -= 1
            self.canvas.image = savedImageArray[currentTouchNumber - 1]
            lastDrawImage = self.canvas.image
            savedImageArray.remove(at: currentTouchNumber)
        }
        // データをAppDelegateの変数に代入
        appDelegate.draftImage = lastDrawImage
        
        // 動作確認用
        print("onClickUndo")
        print(currentTouchNumber)
        print(savedImageArray)
    }
    
    @IBAction func onClickClear(_ sender: Any) {
        // 何かが書かれていたら削除して黒板を最初の状態に戻す
        if lastDrawImage != nil {
            currentTouchNumber += 1
            savedImageArray.append(self.canvas.image!)
            self.canvas.image = nil
            lastDrawImage = nil
            // データをAppDelegateの変数に代入
            appDelegate.draftImage = lastDrawImage
        }
    }
    
    // トップ画面に戻る
    @IBAction func homeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

