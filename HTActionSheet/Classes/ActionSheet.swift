//
//  ActionSheet.swift
//  ActionSheet
//
//  Created by Hunta_Developer on 2018/4/12.
//  Copyright © 2018年 Hunta. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage


// READ ME
/*
 type: （确定）、（取消，确定）（多选）
 imgPath： 图片地址
 title：标题
 message：内容
 selections：多选时的选项
 
 
 func show(type:ActionSheetType, imgPath:String?, title:String?, message:String?, selections:Array<Any>, popType:PopUpViewType)
 */

/*
 e.g
 let actionSheet: ActionSheet = ActionSheet(frame:self.view.frame)
 actionSheet.backgroundColor = UIColor.gray
 actionSheet.delegate = self;
 self.view.addSubview(actionSheet)
 actionSheet.show(type: ActionSheetType.ActionSheet_One_BTN, imgPath: imagePath , title:"对话框标题对话框标题" ,message:"对话框内容对话框内容，对话框内容对话框内容", selections: ["选择一","选择一","选择一"], popType: .ActionSheet)
 */

public struct ActionSheetConfig {
    var kMargin:CGFloat
    var kImageHeight:CGFloat
    var kMSG_Gap:CGFloat
    var kLine_Height:CGFloat
    var kButton_Margin:CGFloat
    var kButton_Font_Size:CGFloat
    var kTitle_Top:CGFloat
    var kTitle_Font_Size:CGFloat
    var kMSG_Font_Size:CGFloat
    var kMSG_Top:CGFloat
    var kMSG_Margin:CGFloat
    var kMSG_Bottom:CGFloat
    var kMSG_Height:CGFloat
    var kCornerRadius:CGFloat
}

public enum ActionSheetType: Int{
    case ActionSheet_One_BTN = 0                    //只有确定的弹出框
    case ActionSheet_Two_BTN                        //取消与确定
    case ActionSheet_Mutible_BTN                    //多按钮
}

public enum PopUpViewType: Int {
    case AlertType = 0                              //从中部
    case ActionSheet                                //从底部
}

//Default config
public let A_KMargin : CGFloat = 10.0               //整体框距离屏幕左右的间距
public let A_KImageHeight : CGFloat = 120.0         //图片的高度
public let A_KMSG_Gap : CGFloat = 20.0              //显示Message的时候距离图片与按钮的间距
public let A_KLine_Height : CGFloat = 50.0          //按钮的高度
public let A_KButton_Margin : CGFloat = 0.5         //分割线大小
public let A_KButton_Font_Size : CGFloat = 16.0     //按钮字体大小
public let A_KTitle_Top : CGFloat = 20.0            //Title TopMargin
public let A_KTitle_Font_Size : CGFloat = 14.0      //Title字体大小
public let A_KMSG_Font_Size : CGFloat = 14.0        //Message字体大小
public let A_KMSG_Top : CGFloat = 10.0              //Message TopMargin
public let A_KMSG_Margin : CGFloat = 35.0           //Message 左右两边距
public let A_KMSG_Bottom : CGFloat = 20.0           //Message BottomMargin
public let A_KMSG_Height : CGFloat = 100.0          //Message 高
public let A_KCornerRadius:CGFloat = 10             //圆角

//代理
public protocol ActionSheetDelegate{
    func ActionSheetSelectedItem(index:Int, title:String)
}

public extension ActionSheetDelegate{
    func ActionSheetSelectedItem(index:Int, title:String){}
}

public class ActionSheet: UIView {

    //试图
    fileprivate var outContainer :UIView!
    fileprivate var upImageView  :UIImageView!
    fileprivate var titleLb      :UILabel!
    fileprivate var scrollView   :UIScrollView!
    fileprivate var msgLb        :UILabel!
    fileprivate var bottomButtonContainer : UIView!
    
    //配置
    public var config : ActionSheetConfig?
    
    //实现代理
    public var delegate : ActionSheetDelegate?
    
    //参数变量
    fileprivate var isConstranis :Bool?
    fileprivate var titleTop: CGFloat!
    fileprivate var msgTop: CGFloat!
    fileprivate var msgBottom: CGFloat!
    fileprivate var imageHeight: CGFloat!
    fileprivate var popType: PopUpViewType!
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame:frame)
        self.isConstranis = false
        self.titleTop = A_KTitle_Top
        self.msgTop = A_KMSG_Top
        self.msgBottom = A_KMSG_Bottom
        self.imageHeight = A_KImageHeight
        self.popType = PopUpViewType.AlertType
        self.config = ActionSheetConfig(kMargin: A_KMargin,
                                        kImageHeight: A_KImageHeight,
                                        kMSG_Gap: A_KMSG_Gap,
                                        kLine_Height: A_KLine_Height,
                                        kButton_Margin: A_KButton_Margin,
                                        kButton_Font_Size: A_KButton_Font_Size,
                                        kTitle_Top: A_KTitle_Top,
                                        kTitle_Font_Size: A_KTitle_Font_Size,
                                        kMSG_Font_Size: A_KMSG_Font_Size,
                                        kMSG_Top: A_KMSG_Top,
                                        kMSG_Margin: A_KMSG_Margin,
                                        kMSG_Bottom: A_KMSG_Bottom,
                                        kMSG_Height: A_KMSG_Height,
                                        kCornerRadius:A_KCornerRadius)
        
        self.outContainer = UIView()
        self.outContainer.backgroundColor = UIColor.white
        self.outContainer.layer.cornerRadius = 10.0
        self.outContainer.clipsToBounds = true
        
        self.upImageView = UIImageView()
        self.upImageView.backgroundColor = self.kRGBColorFromHex(rgbValue: 0xF7F6F8)
        
        self.titleLb = UILabel()
        self.titleLb.textAlignment = .center
        
        self.scrollView = UIScrollView()
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false

        self.msgLb = UILabel()
        self.msgLb.textAlignment = .center
        
        self.msgLb.font = UIFont.systemFont(ofSize: (self.config?.kMSG_Font_Size)!)
        self.msgLb.backgroundColor = UIColor.white
        self.msgLb.numberOfLines = 0
        
        self.bottomButtonContainer = UIView()
        self.bottomButtonContainer.backgroundColor = self.kRGBColorFromHex(rgbValue: 0xEBEBEB)
        self.addSubview(self.outContainer)
        self.outContainer.addSubview(self.upImageView)
        self.outContainer.addSubview(self.titleLb)
        self.outContainer.addSubview(self.scrollView)
        self.scrollView.addSubview(self.msgLb)
        self.outContainer.addSubview(self.bottomButtonContainer)
    }
    
    func bTNGenerator(title:String) -> UIButton {
        let button:UIButton = UIButton()
        button.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button.titleLabel?.font = UIFont.systemFont(ofSize: (self.config?.kButton_Font_Size)!)
        button.setTitle(title, for: UIControlState.normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(self.kRGBColorFromHex(rgbValue:0xFE664F), for: UIControlState.normal)
        button.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
        self.bottomButtonContainer.addSubview(button)
        return button
    }
    
    @objc func tapped(_ sender:UIButton){
        if self.delegate != nil {
            self.delegate?.ActionSheetSelectedItem(index:sender.tag, title: (sender.titleLabel?.text)!)
            self.removeFromSuperview()
        }
    }
    
    public func show(type:ActionSheetType, imgPath:String?, title:String?, message:String?, selections:Array<String>, popType:PopUpViewType){
        self.isConstranis = false
        switch type {
        case .ActionSheet_One_BTN:
            let confirmBTN:UIButton = self.bTNGenerator(title: "确定")
            confirmBTN.tag = 0;
            confirmBTN.snp.makeConstraints({ (make) in
                make.top.equalToSuperview().offset((self.config?.kButton_Margin)!)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo((self.config?.kLine_Height)!)
            })
        case .ActionSheet_Two_BTN:
            let cancelBTN:UIButton = self.bTNGenerator(title: "取消")
            cancelBTN.tag = 0;
            cancelBTN.setTitleColor(self.kRGBColorFromHex(rgbValue:0x333333), for: UIControlState.normal)
            let confirmBTN:UIButton = self.bTNGenerator(title: "确认")
            confirmBTN.tag = 1;

            cancelBTN.snp.makeConstraints({ (make) in
                make.top.equalToSuperview().offset((self.config?.kButton_Margin)!)
                make.left.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo((self.config?.kLine_Height)!)
            })
            confirmBTN.snp.makeConstraints({ (make) in
                make.top.equalToSuperview().offset((self.config?.kButton_Margin)!)
                make.left.equalTo(cancelBTN.snp.right).offset((self.config?.kButton_Margin)!)
                make.bottom.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo((self.config?.kLine_Height)!)
                make.width.equalTo(cancelBTN)
            })
        case .ActionSheet_Mutible_BTN:
            var temp:UIButton? = nil
            for index in 0..<selections.count{
                let btnTitle:String = selections[index]
                let button:UIButton = self.bTNGenerator(title: btnTitle)
                button.tag = index
                if index == 0 {
                    button.snp.makeConstraints({ (make) in
                        make.top.equalToSuperview().offset((self.config?.kButton_Margin)!)
                        make.left.equalToSuperview()
                        make.right.equalToSuperview()
                        make.height.equalTo((self.config?.kLine_Height)!)
                    })
                }else if index == selections.count - 1 {
                    button.snp.makeConstraints({ (make) in
                        make.top.equalTo((temp?.snp.bottom)!).offset((self.config?.kButton_Margin)!)
                        make.left.equalToSuperview()
                        make.right.equalToSuperview()
                        make.height.equalTo((self.config?.kLine_Height)!)
                        make.bottom.equalToSuperview()
                    })
                }else{
                    button.snp.makeConstraints({ (make) in
                        make.top.equalTo((temp?.snp.bottom)!).offset((self.config?.kButton_Margin)!)
                        make.left.equalToSuperview()
                        make.right.equalToSuperview()
                        make.height.equalTo((self.config?.kLine_Height)!)
                    })
                }
                temp = button
            }
        }
        //是否有图片
        if imgPath?.count != 0 && imgPath != nil {
            self.msgTop = 0
            self.msgBottom = self.config?.kMSG_Bottom
            //设置Message
            if title?.count != 0 && title != nil {
                self.titleTop = self.config?.kTitle_Top
                self.titleLb.text = title
            }else{
                self.titleTop = 0
                self.msgBottom = 0
                self.titleLb.text = nil
            }
            //设置Message
            if message?.count != 0 && message != nil {
                self.msgTop = self.config?.kMSG_Top
                self.msgBottom = self.config?.kMSG_Bottom
                self.msgLb.text = message
            }
            let imgUrl:NSURL = NSURL.init(string:imgPath!)!
            self.upImageView.sd_setImage(with:imgUrl as URL, placeholderImage: nil)
        }else{
            self.imageHeight = 0
            //设置Title
            if title?.count != 0 && title != nil {
                self.titleTop = self.config?.kTitle_Top
                self.titleLb.text = title
            }else{
                self.titleTop = 0
                self.titleLb.text = nil
            }
            //设置Message
            if message?.count != 0 && message != nil {
                self.msgTop = self.config?.kMSG_Top
                self.msgBottom = self.config?.kMSG_Bottom
                self.msgLb.text = message
            }else{
                self.msgTop = 0
                self.msgBottom = 0
                self.msgLb.text = nil
            }
        }
        self.popType = popType
        self.updateConstraints()
    }
    
    func kRGBColorFromHex(rgbValue: Int) -> (UIColor) {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,alpha: 1.0)
    }
    
    override public func updateConstraints() {
        if (!isConstranis!) {
            self.outContainer.snp.remakeConstraints({ (make) in
                make.left.equalToSuperview().offset((self.config?.kMargin)!)
                if self.popType == PopUpViewType.AlertType{
                    make.centerY.equalToSuperview()
                }else{
                    make.bottom.equalToSuperview()
                }
                make.right.equalToSuperview().offset(-(self.config?.kMargin)!)
            })
            
            self.upImageView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.outContainer)
                make.left.equalTo(self.outContainer)
                make.right.equalTo(self.outContainer)
                make.height.equalTo(self.imageHeight)
            })
            
            self.titleLb.snp.makeConstraints({ (make) in
                make.top.equalTo(self.upImageView.snp.bottom).offset(self.titleTop)
                make.left.equalTo(self.outContainer)
                make.right.equalTo(self.outContainer)
            })
            
            self.scrollView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.titleLb.snp.bottom).offset(self.msgTop)
                make.left.equalToSuperview().offset((self.config?.kMSG_Margin)!)
                make.right.equalToSuperview().offset(-(self.config?.kMSG_Margin)!)
                make.height.equalTo((self.config?.kMSG_Height)!)
            })
            
            self.msgLb.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
                make.width.equalTo(self.scrollView)
            })
            
            self.bottomButtonContainer.snp.makeConstraints({ (make) in
                make.top.equalTo(self.scrollView.snp.bottom).offset(self.msgBottom)
                make.left.equalToSuperview()
                make.bottom.equalToSuperview()
                make.right.equalToSuperview()
            })
            
            isConstranis = true
        }
        super.updateConstraints()
        
    }
}
