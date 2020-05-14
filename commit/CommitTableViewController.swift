//
//  CommitTableViewController.swift
//  commit
//
//  Created by Сергей Цыганков on 11.05.2020.
//  Copyright © 2020 Сергей Цыганков. All rights reserved.
//

import UIKit

class CommitTableViewController: UITableViewController {
    
    var color = Color(redColor: 0, greenColor: 0, blueColor: 0, alpha: 0)
    var colors = [Color(redColor: 1, greenColor: 0, blueColor: 0, alpha: 0.5),
                  Color(redColor: 1, greenColor: 0.5, blueColor: 0, alpha: 0.5),
                  Color(redColor: 1, greenColor: 1, blueColor: 0.5, alpha: 0.5),
                  Color(redColor: 0.5, greenColor: 1, blueColor: 0.5, alpha: 0.5),
                  Color(redColor: 0, greenColor: 1, blueColor: 0, alpha: 0.5)]
    
    var commits =
        [Commits(name: "Good", description: "Very good", mark: 10, image: "bag", haveColor: true),
         Commits(name: "Middle", description: "Middle one", mark: 5, image: "bag", haveColor: false),
         Commits(name: "Bad", description: "Very bad", mark: 1, image: "bag", haveColor: true)]
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Commits"
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
    
    //установка значений в ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CommitTableViewCell
        let commit = commits[indexPath.row]
        cell.set(commit: commit)
        //делаем цвет, зависящий от отзыва
        if commit.haveColor {
            let id = setColor(mark: commit.mark)
            cell.backgroundColor = UIColor(red: CGFloat(colors[id].redColor), green: CGFloat(colors[id].greenColor), blue: CGFloat(colors[id].blueColor), alpha: CGFloat(colors[id].alpha))
        }
        return cell
    }
    
    private func setColor(mark: Int ) -> Int {
        var id = 0
        
        switch mark {
        case 0...2:
            id = 0
        case 3...4:
            id = 1
        case 5...6:
            id = 2
        case 7...8:
            id = 3
        case 9...10:
            id = 4
        default:
            id = 0
        }

        return id
    }
    
    //MARK: связать измененные цвета первого и второго контроллеров
    //метод по активации второго вью при нажатии на ячейку для реадктирования
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //guard segue.identifier == "editCommit" else { return }
        if segue.identifier == "editCommit" {
        let indexPath = tableView.indexPathForSelectedRow!
        let commit = commits[indexPath.row]
        let navigationAC = segue.destination as! UINavigationController
        let additingAVC = navigationAC.topViewController as! NewCommitTableViewController
        additingAVC.commit = commit
        additingAVC.title = "Edit"
        } else {
        //добавляем переход на окно редактирования цвета
        guard segue.identifier == "changeColor" else { return }
        let navigationCVC = segue.destination as! UINavigationController
        let colorCVC = navigationCVC.topViewController as! ColorViewController
        colorCVC.colors = colors
        colorCVC.title = "Find your color"
        }
    }
    
    //метод по возврату со второго вью на первый
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
       // guard segue.identifier == "save" else { return }
        if segue.identifier == "save" {
        let soursVC = segue.source as! NewCommitTableViewController
        let commit = soursVC.commit
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            commits[selectedIndexPath.row] = commit
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: commits.count, section: 0)
            commits.append(commit)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
        } else {
        //возвращение с настройки цветов
        guard segue.identifier == "endChangeColor" else { return }
        let colorVC = segue.source as! ColorViewController
        colors = colorVC.colors
        
        tableView.reloadData()
        }
    }
    
    //чтоб можно было удалять, хз для чего!!!!!!!!!!!!
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //тут происходит удаление ячейки
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            commits.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //даем право двигать ячейки
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //прописываем изменение движения ячеик и изменение цета при этом (быть аккуратнееб возможны баги!!!!!)
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveCommit = commits.remove(at: sourceIndexPath.row)
        //изменение цвета при передвижении ячеик
        self.tableView.cellForRow(at: sourceIndexPath)?.backgroundColor = .none
        self.tableView.cellForRow(at: destinationIndexPath)?.backgroundColor = .none
        commits.insert(moveCommit, at: destinationIndexPath.row)
        
        //перезакраска ячеик
        if sourceIndexPath.row > destinationIndexPath.row {
            for element in 0...sourceIndexPath.row {
                 if self.commits[element].haveColor {
                    let id = self.setColor(mark: self.commits[element].mark)
                self.tableView.cellForRow(at: IndexPath(row: element, section: 0))?.backgroundColor = UIColor(red: CGFloat(self.colors[id].redColor), green: CGFloat(self.colors[id].greenColor), blue: CGFloat(self.colors[id].blueColor), alpha: CGFloat(self.colors[id].alpha))
                } else {
                self.tableView.cellForRow(at: IndexPath(row: element, section: 0))?.backgroundColor = .none//
                }
            }
        } else {
            for element in 0...destinationIndexPath.row {
                if self.commits[element].haveColor { //
                let id = self.setColor(mark: self.commits[element].mark)
                self.tableView.cellForRow(at: IndexPath(row: element, section: 0))?.backgroundColor = UIColor(red: CGFloat(self.colors[id].redColor), green: CGFloat(self.colors[id].greenColor), blue: CGFloat(self.colors[id].blueColor), alpha: CGFloat(self.colors[id].alpha))
                } else {//
                    self.tableView.cellForRow(at: IndexPath(row: element, section: 0))?.backgroundColor = .none//
                }
            }
        }
        
        
        //MARK: при перемещении бесцветного cell он окрашивается, исправить
        tableView.reloadData()
    }
    
    
    //рисуем при свайпе вправо
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let color = makeColor(at: indexPath)
        return UISwipeActionsConfiguration(actions: [color])
    }
    
    
    //MARK: тут менять вывод цвета
    //при перемещении ячейки неокрашенной на место окрашенной, она окрашивается
    func makeColor(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "color") { (action, view, complite) in
            self.commits[indexPath.row].haveColor = !self.commits[indexPath.row].haveColor
            if self.commits[indexPath.row].haveColor {
                let id = self.setColor(mark: self.commits[indexPath.row].mark)
                self.tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor(red: CGFloat(self.colors[id].redColor), green: CGFloat(self.colors[id].greenColor), blue: CGFloat(self.colors[id].blueColor), alpha: CGFloat(self.colors[id].alpha))
            } else {
                self.tableView.cellForRow(at: indexPath)?.backgroundColor = .none
            }
        }
        action.backgroundColor = .blue
        self.tableView.reloadData()
        action.image = UIImage(systemName: "paintbrush")
        return action
    }
  
    
}
