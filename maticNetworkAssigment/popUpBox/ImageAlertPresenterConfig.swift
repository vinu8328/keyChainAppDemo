//
//  ImageAlertPresenterConfig.swift
//  ImageAlertPresenter


import UIKit

struct ImageAlertPresenterConfig {
    let title: String?
    let message: String?
    let close: String
   // let completeTitle: String
    let imageViewHeight: CGFloat?
    let imageViewWidth: CGFloat?
    let imageViewVerticalOffset: CGFloat
    let imageViewContentMode: UIView.ContentMode
    
    init(title: String? =                               nil,
         message: String? =                             nil,
         close: String =                          "Close",
       //  completeTitle: String =                        "Complete",
         imageViewHeight: CGFloat? =                    70,
         imageViewWidth: CGFloat? =                     70,
         imageViewVerticalOffset: CGFloat =             24.0,
         imageViewContentMode: UIView.ContentMode =      .scaleAspectFill) {
        
        self.title = title
        self.message = message
        self.close = close
      //  self.completeTitle = completeTitle
        self.imageViewHeight = imageViewHeight
        self.imageViewWidth = imageViewWidth
        self.imageViewVerticalOffset = imageViewVerticalOffset
        self.imageViewContentMode = imageViewContentMode
    }
}
