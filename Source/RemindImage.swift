//
//  RemindImage.swift
//  Remind
//
//  Created by LC on 2023/9/18.
//

import UIKit

public class RemindImage {
    
    public static var color = UIColor.white
    
    public struct Cache {
        public static var success: UIImage?
        public static var error: UIImage?
        public static var info: UIImage?
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
            let point = UIBezierPath()
            point.addArc(withCenter: CGPoint(x: 18, y: 10), radius: 1, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
            point.close()
            RemindImage.color.setFill()
            point.fill()
            
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 15))
            checkmarkShapePath.addLine(to: CGPoint(x: 18, y: 27))
            checkmarkShapePath.close()
        }
        
        RemindImage.color.setStroke()
        checkmarkShapePath.stroke()
    }
    class var successImage: UIImage {
        if (Cache.success != nil) {
            return Cache.success!
        }
        Cache.success = UIGraphicsImageRenderer(size: CGSize(width: 36, height: 36)).image { _ in
            draw(.success)
        }
        return Cache.success!
    }
    class var errorImage: UIImage {
        if (Cache.error != nil) {
            return Cache.error!
        }
        Cache.error = UIGraphicsImageRenderer(size: CGSize(width: 36, height: 36)).image { _ in
            draw(.error)
        }
        return Cache.error!
    }
    
    class var infoImage: UIImage {
        if (Cache.info != nil) {
            return Cache.info!
        }
        Cache.info = UIGraphicsImageRenderer(size: CGSize(width: 36, height: 36)).image { _ in
            draw(.info)
        }
        return Cache.info!
    }
}
