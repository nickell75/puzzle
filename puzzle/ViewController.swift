//  Created by Joshua Nickell on 2/3/19.
//  Copyright © 2019 Joshua Nickell. All rights reserved.

import UIKit
class ViewController: UIViewController {

    var gameViewWidth : CGFloat!
    var blockWidth : CGFloat!
//    for location of blocks
    var xAxis : CGFloat!
    var yAxis : CGFloat!
//    arrays for block numbers and locations
    var blockArr : NSMutableArray = []
    var axisArr : NSMutableArray = []
    
    @IBOutlet weak var gameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildBlocks()
        randomLocation()
    }
    func buildBlocks(){
        blockArr = []
        axisArr = []
        
        gameViewWidth = gameView.frame.size.width
        blockWidth = gameViewWidth / 4
        
        xAxis = blockWidth / 2
        yAxis = blockWidth / 2
        
        var numLabel : Int = 1
//    iterate for each row(4)
        for _ in 0..<4{
//        iterate for each block in line(4)
            for _ in 0..<4 {
//            create block
                let blockFrame : CGRect = CGRect(x: 0, y: 0, width: blockWidth-6, height: blockWidth-6)
                let block: UILabel = UILabel(frame: blockFrame)
//            find center point for block for alignment
                block.center = CGPoint(x: xAxis, y: yAxis)
//            add number label for each block
                block.text = String(numLabel)
//            block styling
                block.textAlignment = NSTextAlignment.center
                block.textColor = UIColor.white
                block.font = UIFont(name: "Helvetica-Bold", size: 30)
                block.backgroundColor = UIColor.blue
//            needed to add block to gameView
                gameView.addSubview(block)
                
                blockArr.add(block)
                axisArr.add(CGPoint(x: xAxis, y: yAxis))
//            increment items(label and location)
                numLabel += 1
                xAxis +=  blockWidth
            }
//        increment to next row, reset line to first block in row
            xAxis = blockWidth / 2
            yAxis += blockWidth
        }
//    remove last block(16)
        let lastBlock : UILabel = blockArr[15] as! UILabel
        lastBlock.removeFromSuperview()
        blockArr.removeObject(at: 15)
    }
    
    func randomLocation(){
        let tempArr : NSMutableArray = axisArr.mutableCopy() as! NSMutableArray
        for eachBlock in blockArr{
            let randIndex : Int = Int.random(in: 0 ..< tempArr.count)
            let randCenter : CGPoint = tempArr[randIndex] as! CGPoint
//        place block in random location and remove index number from array so it wont get used again
            (eachBlock as! UILabel).center = randCenter
            tempArr.removeObject(at: randIndex)
            
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        randomLocation()
    }
    
}

