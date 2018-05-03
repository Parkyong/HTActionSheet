# HTActionSheet

[![CI Status](https://img.shields.io/travis/piaoyong.com@hotmail.com/HTActionSheet.svg?style=flat)](https://travis-ci.org/piaoyong.com@hotmail.com/HTActionSheet)
[![Version](https://img.shields.io/cocoapods/v/HTActionSheet.svg?style=flat)](https://cocoapods.org/pods/HTActionSheet)
[![License](https://img.shields.io/cocoapods/l/HTActionSheet.svg?style=flat)](https://cocoapods.org/pods/HTActionSheet)
[![Platform](https://img.shields.io/cocoapods/p/HTActionSheet.svg?style=flat)](https://cocoapods.org/pods/HTActionSheet)

## Screentshot
<div align="center">
<img src="https://github.com/Parkyong/HTActionSheet/blob/master/%E5%8D%95%E9%80%89.png" width="150px" height="auto">
<img src="https://github.com/Parkyong/HTActionSheet/blob/master/%E5%8F%8C%E9%80%89.png" width="150px" height="auto">
<img src="https://github.com/Parkyong/HTActionSheet/blob/master/%E5%A4%9A%E9%80%89.png" width="150px" height="auto">
<img src="https://github.com/Parkyong/HTActionSheet/blob/master/%E4%B8%AD%E9%97%B4%E6%98%BE%E7%A4%BA.png" width="150px" height="auto">
</div>


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

    let imagePath = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525338866727&di=4071bf3816c4ddd86e9d85fbc7df0387&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D8b20ba278d94a4c21e2eef68669d71a0%2F7c1ed21b0ef41bd5f0c6b3dc5bda81cb39db3d04.jpg"
        let actionSheet: ActionSheet = ActionSheet(frame:self.view.frame)
        actionSheet.backgroundColor = UIColor.gray
        actionSheet.delegate = self;
        self.view.addSubview(actionSheet)
        actionSheet.show(type: ActionSheetType.ActionSheet_Mutible_BTN, imgPath: imagePath , title:"对话框标题对话框标题" ,message:"对话框内容对话框内容，对话框内容对话框内容", selections: ["选择一","选择一","选择一"], popType: .AlertType)



## Requirements

## Installation

HTActionSheet is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HTActionSheet'
```

## Author

piaoyong.com@hotmail.com, m18611421005@163.com

## License

HTActionSheet is available under the MIT license. See the LICENSE file for more info.
