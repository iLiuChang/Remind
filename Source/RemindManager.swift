//
//  RemindManager.swift
//  Remind
//
//  Created by LC on 2023/9/18.
//

import UIKit
public class RemindManager: NSObject {
    
    public static var config = Config()
    public struct Config {
        public var font = UIFont.systemFont(ofSize: 13)
        public var maximumStayTime: TimeInterval = 10
        public var minimumStayTime: TimeInterval = 2
        public var backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.8)
        public var textColor = UIColor.white
    }
    
    @discardableResult
    public class func wait(text: String?, in view: UIView) -> UIView {
        
        let bgView = UIView(frame: view.bounds)
        view.addSubview(bgView)
        
        let mainView = UIView()
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = config.backgroundColor
        
        let imageW: CGFloat = 36
        let padding: CGFloat = 30
        let checkmarkView = UIActivityIndicatorView(style: .whiteLarge)
        checkmarkView.frame = CGRect(x: padding, y: padding, width: imageW, height: imageW)
        checkmarkView.startAnimating()
        mainView.addSubview(checkmarkView)

        if let bottomText = text, !bottomText.isEmpty {
            let label = UILabel()
            label.text = text
            label.numberOfLines = 0
            label.font = config.font
            label.textAlignment = .center
            label.textColor = config.textColor
            let size = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width-82, height: CGFloat.greatestFiniteMagnitude))
            label.frame = CGRect(x: padding, y: imageW + padding + 10, width: max(size.width, imageW), height: size.height)
            mainView.addSubview(label)
            
            let frame = CGRect(x: 0, y: 0, width: label.frame.width + label.frame.origin.x * 2, height: label.frame.maxY + padding)
            var imageFrame = checkmarkView.frame
            imageFrame.origin.x = (frame.width - imageFrame.size.width) / 2
            checkmarkView.frame = imageFrame
            mainView.frame = frame
            
            mainView.center = view.center
            view.addSubview(mainView)

        } else {
            let frame = CGRect(x: 0, y: 0, width: imageW + padding*2, height: imageW + padding*2)
            mainView.frame = frame
            mainView.center = view.center
        }

        bgView.addSubview(mainView)

        bgView.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            bgView.alpha = 1
        })
        return bgView
    }
    
    @discardableResult
    public class func show(text: String, stay time: TimeInterval = 0, in view: UIView) -> UIView {
        let mainView = UIView()
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = config.backgroundColor
        
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = config.font
        label.textAlignment = NSTextAlignment.center
        label.textColor = config.textColor
        let size = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width-82, height: CGFloat.greatestFiniteMagnitude))
        label.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        mainView.addSubview(label)
        
        let superFrame = CGRect(x: 0, y: 0, width: label.frame.width + 40 , height: label.frame.height + 30)
        mainView.frame = superFrame
        
        label.center = mainView.center
        mainView.center = view.center
        view.addSubview(mainView)
        self.perform(#selector(dismiss(sender:)), with: mainView, afterDelay: makeTime(text, time: time))
        return mainView
    }
    
    @discardableResult
    public class func show(type: RemindImage.ImageType, text: String, stay time: TimeInterval = 0, in view: UIView) -> UIView {
        let mainView = UIView()
        mainView.layer.cornerRadius = 10
        mainView.backgroundColor = config.backgroundColor
        let iconView = UIImageView(image: type.image)
        iconView.frame = CGRect(x: 0, y: 15, width: 36, height: 36)
        mainView.addSubview(iconView)
        
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = config.font
        label.textAlignment = .center
        label.textColor = config.textColor
        let size = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width-82, height: CGFloat.greatestFiniteMagnitude))
        label.frame = CGRect(x: 20, y: iconView.frame.maxY + 10, width: max(size.width, iconView.frame.size.width), height: size.height)
        mainView.addSubview(label)
        
        let frame = CGRect(x: 0, y: 0, width: label.frame.width + label.frame.origin.x * 2, height: label.frame.maxY + 15)
        var imageFrame = iconView.frame
        imageFrame.origin.x = (frame.width - imageFrame.size.width) / 2
        iconView.frame = imageFrame
        mainView.frame = frame
        
        mainView.center = view.center
        view.addSubview(mainView)
        
        mainView.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            mainView.alpha = 1
        })
        
        self.perform(#selector(dismiss(sender:)), with: mainView, afterDelay: makeTime(text, time: time))
        return mainView
    }
    
    @objc private class func dismiss(sender: AnyObject) {
        if let window = sender as? UIView {
            UIView.animate(withDuration: 0.2, animations: {
                window.alpha = 0
            }, completion: { b in
                window.removeFromSuperview()
            })
        }
    }
    
    private class func makeTime(_ text: String, time: TimeInterval) -> TimeInterval {
        if time > 0 {
            return time
        } else {
            let minimum = max(TimeInterval(text.count) * 0.06 + 0.5, RemindManager.config.maximumStayTime)
            return min(minimum, RemindManager.config.minimumStayTime)
        }
    }
}

