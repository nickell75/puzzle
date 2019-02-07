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
    
    var lastBlock : CGPoint!
    
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
                block.isUserInteractionEnabled = true
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
//        locate empty position on board, last element available in arr(16 in axis arr - 15 in block arr)
        lastBlock = tempArr[0] as! CGPoint
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let userTouch : UITouch = touches.first!
        if (blockArr.contains(userTouch.view as Any)){
            let touchView : UILabel = (userTouch.view) as! UILabel
            let xDif : CGFloat = (touchView.center.x - lastBlock.x)
            let yDif : CGFloat = (touchView.center.y - lastBlock.y)
            let distance : CGFloat = sqrt(pow(xDif, 2) + pow(yDif, 2))
            
            if (distance == blockWidth){
                let tempCenter : CGPoint = touchView.center

                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.2)
                
                touchView.center = lastBlock
                UIView.commitAnimations()
   
                lastBlock = tempCenter

            } else if(distance == blockWidth * 3){
                print(axisArr)
//                var arr = Array(count: 3, repeatedValue: Array(count: 3, repeatedValue: 0))

//                use to move multiple blocks at once
//                UIView.animate(animations: { () -> Void in
//                  let tempCenter : CGPoint = touchView.center     initial touch becomes becomes temp 3
//                  let tempCenter1 : CGPoint(x: , y: )             adjacent to last block becomes last block
//                  let tempCenter2 : CGPoint(x: , y: )             2 adjacent to last block becomes temp 1
//                  let tempCenter3 : CGPoint(x: , y: )             3 adjacent to last block becomes temp 2
//
//                  touchView.center = tempCenter3
//                  tempCenter3 = tempCenter2
//                  lastBlock = tempCenter

            }
        }
        
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        randomLocation()
    }
    
}

