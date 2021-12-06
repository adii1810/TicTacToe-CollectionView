	

import UIKit

class ticktactoeViewController: UIViewController {

    private var data = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,]
    
    private var u1 = 0
    private var u2 = 0
    
    private let winningCombinations = [[0, 1, 2,3], [4, 5,6,7], [8,9,10,11], [12, 13, 14,15], [0, 4, 8,12], [1, 5, 9,13], [2,6,10,14], [3,7,11,15],[0,5,10,15],[3,6,9,12]]
    
    
    private var zeroflag = false
    
    private let lbl1 : UILabel = {
        let l1 = UILabel()
        l1.text = "0"
        l1.textColor = .black
        return l1
        }()
    
    private let lbl_1 : UILabel = {
        let l1 = UILabel()
        l1.text = "Player O:"
        l1.textColor = .black
        return l1
    }()
    
    private let lbl_2 : UILabel = {
        let l1 = UILabel()
        l1.text = "Player X:"
        l1.textColor = .black
        return l1
    }()
    
    private let lbl2 : UILabel = {
        let l2 = UILabel()
        l2.text = "0"
        l2.textColor = .black
        return l2
    }()
    
    private let tickCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 120, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .yellow
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tickCollectionView)
        view.addSubview(lbl1)
        view.addSubview(lbl2)
        view.addSubview(lbl_1)
        view.addSubview(lbl_2)
        setupcellview()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lbl_1.frame = CGRect(x: 30, y: 70, width: 100, height: 20)
        lbl_2.frame = CGRect(x: 30, y: 110, width: 100, height: 20)
        
        lbl1.frame = CGRect(x: 105, y: 70, width: 100, height: 20)
        lbl2.frame = CGRect(x: 105, y: 110, width: 100, height: 20)
        tickCollectionView.frame = CGRect(x: 20, y: 150, width: 335, height: 500)
        
    }    
}

    extension ticktactoeViewController: UICollectionViewDataSource,UICollectionViewDelegate{
        
        private func setupcellview(){
            tickCollectionView.dataSource = self
            tickCollectionView.delegate = self
            
            tickCollectionView.register(T4CellCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return data.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            	let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! T4CellCollectionViewCell
                cell.setupcell(with: data[indexPath.row])
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if data[indexPath.row] != 0 && data[indexPath.row] != 1{
                
                data.remove(at: indexPath.row)
                
                if zeroflag{
                    data.insert(0, at: indexPath.row)
                }
                else{
                    data.insert(1, at: indexPath.row)
                }
                
                zeroflag = !zeroflag
                
                DispatchQueue.main.async {
                    collectionView.reloadData()
                   // collectionView.reloadSections(IndexSet(integer: 0))
                    self.checkwinner()
                    
                }
                
            }
        }
    private func checkwinner(){
        if !data.contains(2){
            print("draw")
        }
        else{
            for i in winningCombinations{
                if data[i[0]] == data[i[1]] && data[i[1]] == data[i[2]] && data[i[2]] == data[i[3]] && data[i[0]] != 2{
                  
                    print("\(data[i[0]]) won")
                    
                    var msg = ""
                    if data[i[0]] == 1 {
                        msg = "Cross"
                        u1 = u1+1
                        lbl1.text = "\(u1)"
                    }
                    else if data[i[0]] == 0 {
                        msg = "Zero"
                        u2 = u2+1
                        lbl2.text = "\(u2)"
                    }
                    
                    let alert = UIAlertController(title: title, message: "\(msg) You Win ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    
                    DispatchQueue.main.async {
                        self.present(alert,animated: true)
                        
                    }
                    reset()
                    break
                }
            }
        }
    }
        
        private func reset(){
            data = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]
            zeroflag = false
            
            tickCollectionView.reloadData()
        }
}
