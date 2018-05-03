//
//  ViewController.swift
//  HTActionSheet
//
//  Created by piaoyong.com@hotmail.com on 05/03/2018.
//  Copyright (c) 2018 piaoyong.com@hotmail.com. All rights reserved.
//

import UIKit
import HTActionSheet

class ViewController: UIViewController, ActionSheetDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let imagePath = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525338866727&di=4071bf3816c4ddd86e9d85fbc7df0387&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D8b20ba278d94a4c21e2eef68669d71a0%2F7c1ed21b0ef41bd5f0c6b3dc5bda81cb39db3d04.jpg"
        let actionSheet: ActionSheet = ActionSheet(frame:self.view.frame)
        actionSheet.backgroundColor = UIColor.gray
        actionSheet.delegate = self;
        self.view.addSubview(actionSheet)
        actionSheet.show(type: ActionSheetType.ActionSheet_Mutible_BTN, imgPath: imagePath , title:"对话框标题对话框标题" ,message:"对话框内容对话框内容，对话框内容对话框内容", selections: ["选择一","选择一","选择一"], popType: .AlertType)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

