//
//  ColorViewController.swift
//  commit
//
//  Created by Сергей Цыганков on 13.05.2020.
//  Copyright © 2020 Сергей Цыганков. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    
    var id = 0

    var colors = [Color(redColor: 1, greenColor: 0, blueColor: 0, alpha: 0.5),
                  Color(redColor: 1, greenColor: 0.5, blueColor: 0, alpha: 0.5),
                  Color(redColor: 1, greenColor: 1, blueColor: 0.5, alpha: 0.5),
                  Color(redColor: 0.5, greenColor: 1, blueColor: 0.5, alpha: 0.5),
                  Color(redColor: 0, greenColor: 1, blueColor: 0, alpha: 0.5)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
        changeColor()
    }
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var alphaSlide: UISlider!
    @IBOutlet weak var markSlide: UISlider!
    
    @IBAction func showColor(_ sender: UISwitch) {
    }
    @IBAction func setStandart(_ sender: UIBarButtonItem) {
        var (r,g,b): (Float, Float, Float) = (0,0,0)
        switch id {
        case 0:
            (r,g,b) = (1,0,0)
        case 1:
            (r,g,b) = (1,0.5,0)
        case 2:
            (r,g,b) = (1,1,0.5)
        case 3:
            (r,g,b) = (0.5,1,0.5)
        case 4:
            (r,g,b) = (0,1,0)
        default:
            break
        }
        redSlide.value = r
        greenSlide.value = g
        blueSlide.value = b
        alphaSlide.value = 0.5
        
        changeColor()
        
        colors[id].redColor = r
        colors[id].greenColor = g
        colors[id].blueColor = b
        colors[id].alpha = 0.5
        //вернуть стандартную настройку цвета (сделать для каждого диапазона отдельно)
    }
    
    // настраиваем слайдеры для изменения цвета
    @IBOutlet weak var redSlide: UISlider! {
        didSet {
            redSlide.transform = CGAffineTransform(rotationAngle: -.pi/2)
            redSlide.tintColor = UIColor.red
        }
    }
    @IBOutlet weak var greenSlide: UISlider! {
        didSet {
            greenSlide.transform = CGAffineTransform(rotationAngle: -.pi/2)
            greenSlide.tintColor = UIColor.green
        }
    }
    @IBOutlet weak var blueSlide: UISlider! {
        didSet {
            blueSlide.transform = CGAffineTransform(rotationAngle: -.pi/2)
            blueSlide.tintColor = UIColor.blue
        }
    }
    
    
    
    @IBAction func changeMark(_ sender: UISlider) {
        findMark()
        redSlide.value = colors[id].redColor
        greenSlide.value = colors[id].greenColor
        blueSlide.value = colors[id].blueColor
        alphaSlide.value = colors[id].alpha
        changeColor()
    }
    
    //установка счетчика для массива и изменение лейбла передачи
    func findMark() {
        switch markSlide.value {
        case 0...2:
            markLabel.text = "0..2"
            id = 0
        case 3...4:
            markLabel.text = "3..4"
            id = 1
        case 5...6:
            markLabel.text = "5..6"
            id = 2
        case 7...8:
            markLabel.text = "7..8"
            id = 3
        case 9...10:
            markLabel.text = "9..10"
            id = 4
        default:
            break
        }
    }
    
    
    
    //изменение цвета сладерами
    @IBAction func changeColor(_ sender: UISlider) {
        setColor()
        
        changeColor()
    }
    
    //подгрузка начальных значений
    func start() {
        redSlide.value = colors[0].redColor
        greenSlide.value = colors[0].greenColor
        blueSlide.value = colors[0].blueColor
        alphaSlide.value = colors[0].alpha
        markSlide.value = 2
    }
    
    //установка значений со сладеров в массив
    func setColor() {
        colors[id].redColor = redSlide.value
        colors[id].greenColor = greenSlide.value
        colors[id].blueColor = blueSlide.value
        colors[id].alpha = alphaSlide.value
    }
    
    
    //установка цвета в поле
    func changeColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlide.value), green: CGFloat(greenSlide.value), blue: CGFloat(blueSlide.value), alpha: CGFloat(alphaSlide.value))
    }
    
    
}
