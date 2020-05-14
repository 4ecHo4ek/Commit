//
//  NewCommitTableViewController.swift
//  commit
//
//  Created by Сергей Цыганков on 12.05.2020.
//  Copyright © 2020 Сергей Цыганков. All rights reserved.
//

import UIKit

class NewCommitTableViewController: UITableViewController {
    
    var commit = Commits(name: "", description: "", mark: 0, image: "", haveColor: false, info: "")
    
    @IBOutlet weak var svaeButton: UIBarButtonItem!
    @IBOutlet weak var imageName: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var indoTF: UITextField!
    @IBOutlet weak var markTF: UILabel!
    @IBOutlet weak var slider: UISlider! {
        didSet {
            slider.maximumValue = 10
            slider.minimumValue = 0
            slider.value = 0
        }
    }
    
    //выставление оценки в лейбл
    @IBAction func markSlider(_ sender: UISlider) {
        markTF.text = String(Int(round(slider.value)))
    }
    
    //рисуем сразу после добавления фотографии (названия)
    @IBAction func printImage(_ sender: UITextField) {
        guard let print = imageName.text else { return }
        image.image = UIImage(systemName: print)
    }
    
    //проверяем на наличие записи в имени
    @IBAction func hasName(_ sender: UITextField) {
        updateButton()
    }
    
    //активация кнопки сохранить, если введено имя
    private func updateButton() {
        let nameText = nameTF.text ?? ""
        svaeButton.isEnabled = !nameText.isEmpty
    }
    
    //высталвение значений при редактировании
    private func updateUI() {
        nameTF.text = commit.name
        imageName.text = commit.image
        descriptionTF.text = commit.description
        markTF.text = String(commit.mark)
        indoTF.text = commit.info
        image.image = UIImage(systemName: commit.image)
        slider.value = Float(commit.mark)
    }
    
    //метод по обновлению информации в хранилище
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "save" else { return }
        let name = nameTF.text ?? ""
        let description = descriptionTF.text ?? ""
        let mark = Int(markTF.text ?? "")
        let image = imageName.text ?? ""
        let info = indoTF.text ?? ""
        
        self.commit = Commits(name: name, description: description, mark: mark ?? 0, image: image, haveColor: false, info: info)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //подгрузка при созданни вида
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateButton()
    }
}
