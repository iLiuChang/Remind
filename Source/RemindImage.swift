//
//  RemindImage.swift
//  Remind
//
//  Created by LC on 2023/9/18.
//

import UIKit

public class RemindImage {
    public struct Cache {
        static var success: UIImage?
        static var error: UIImage?
        static var info: UIImage?
    }
    
    public enum ImageType{
        case success
        case error
        case info
        
        var image: UIImage {
            switch self {
            case .success:
                return successImage
            case .error:
                return errorImage
            case .info:
                return infoImage
            }
        }
    }

    class func draw(_ type: ImageType) {
        let checkmarkShapePath = UIBezierPath()
        checkmarkShapePath.move(to: CGPoint(x: 36, y: 18))
        checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 18), radius: 17.5, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        checkmarkShapePath.close()
        switch type {
        case .success:
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.addLine(to: CGPoint(x: 16, y: 24))
            checkmarkShapePath.addLine(to: CGPoint(x: 27, y: 13))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.close()
        case .error:
            checkmarkShapePath.move(to: CGPoint(x: 12, y: 12))
            checkmarkShapePath.addLine(to: CGPoint(x: 24, y: 24))
            checkmarkShapePath.move(to: CGPoint(x: 12, y: 24))
            checkmarkShapePath.addLine(to: CGPoint(x: 24, y: 12))
            checkmarkShapePath.close()
        case .info:
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 10))
            checkmarkShapePath.addLine(to: CGPoint(x: 18, y: 21))
            checkmarkShapePath.close()
            
            UIColor.white.setStroke()
            checkmarkShapePath.stroke()
            
            let checkmarkShapePath = UIBezierPath()
            checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 26), radius: 1, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
            checkmarkShapePath.close()
            
            UIColor.white.setFill()
            checkmarkShapePath.fill()
        }
        
        UIColor.white.setStroke()
        checkmarkShapePath.stroke()
    }
    class var successImage: UIImage {
        if (Cache.success != nil) {
            return Cache.success!
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
        draw(.success)
        Cache.success = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.success!
    }
    class var errorImage: UIImage {
        if (Cache.error != nil) {
            return Cache.error!
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
        draw(.error)
        Cache.error = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.error!
    }
    
    class var infoImage: UIImage {
        if (Cache.info != nil) {
            return Cache.info!
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
        draw(.info)
        Cache.info = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.info!
    }
}
