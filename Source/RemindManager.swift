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
        public var padding: CGFloat = 20
        public var activityIndicatorColor: UIColor = .white

    }
    
    @discardableResult
    public class func wait(text: String?, in view: UIView) -> UIView {
        
        let bgView = UIView()
        bgView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgView)
        NSLayoutConstraint.activate([
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.topAnchor.constraint(equalTo: view.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let mainView = UIView()
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = config.backgroundColor
        mainView.translatesAutoresizingMaskIntoConstraints = false
        bgView.addSubview(mainView)

        var activityIndicator: UIActivityIndicatorView!
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .large)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        }
        activityIndicator.color = config.activityIndicatorColor
        activityIndicator.startAnimating()
        mainView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: mainView.topAnchor, constant: config.padding),
            activityIndicator.centerXAnchor.constraint(equalTo: mainView.centerXAnchor)
        ])

        if let bottomText = text, !bottomText.isEmpty {
            let label = UILabel()
            label.text = text
            label.numberOfLines = 0
            label.font = config.font
            label.textAlignment = .center
            label.textColor = config.textColor
            mainView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
                label.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor),
                label.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -config.padding),
                label.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: config.padding),
                label.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -config.padding),

            ])
            view.addSubview(mainView)

            NSLayoutConstraint.activate([
                mainView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -80),
                mainView.widthAnchor.constraint(greaterThanOrEqualTo: mainView.heightAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                mainView.widthAnchor.constraint(equalTo: activityIndicator.widthAnchor, constant: config.padding*2),
                mainView.heightAnchor.constraint(equalTo: activityIndicator.heightAnchor, constant: config.padding*2),
            ])
        }

        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
        ])

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
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -80)
        ])

        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = config.font
        label.textAlignment = NSTextAlignment.center
        label.textColor = config.textColor
        mainView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 15
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -padding),
            label.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: padding),
            label.topAnchor.constraint(equalTo: mainView.topAnchor, constant: padding),
            label.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -padding)
        ])

        if time >= 0 {
            self.perform(#selector(dismiss(sender:)), with: mainView, afterDelay: makeTime(text, time: time))
        }
        return mainView
    }
    
    @discardableResult
    public class func show(type: RemindImage.ImageType, text: String, stay time: TimeInterval = 0, in view: UIView) -> UIView {
        let mainView = UIView()
        mainView.layer.cornerRadius = 10
        mainView.backgroundColor = config.backgroundColor
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -80),
            mainView.widthAnchor.constraint(greaterThanOrEqualTo: mainView.heightAnchor)
        ])

        let iconView = UIImageView(image: type.image)
        mainView.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            iconView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: config.padding),
            iconView.widthAnchor.constraint(equalToConstant: 36),
            iconView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = config.font
        label.textAlignment = .center
        label.textColor = config.textColor
        mainView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -config.padding),
            label.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: config.padding),
            label.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -config.padding)
        ])
        

        mainView.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            mainView.alpha = 1
        })
        
        if time >= 0 {
            self.perform(#selector(dismiss(sender:)), with: mainView, afterDelay: makeTime(text, time: time))
        }
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

