//
//  HomeSliderTableViewCell.swift
//  TemployMe
//
//  Created by A2 MacBook Pro 2012 on 06/12/21.
//

import UIKit
import ImageSlideshow
import CHIPageControl

class HomeSliderTableViewCell: UITableViewCell {
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var pageControl: CHIPageControlJaloro!
     override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupSlideShow(promotionBanner : [PramotionBanners]?) {
        slideshow.contentScaleMode = .scaleAspectFill
        slideshow.slideshowInterval = 3.0
        var imagesSources: [AlamofireSource] = []
        for banner in promotionBanner ?? [] {
            let inputSource = AlamofireSource.init(url: URL(string: banner.image_path!)!, placeholder: UIImage(named: "slider-banner"))
            imagesSources.append(inputSource)
        }
        
        slideshow.setImageInputs(imagesSources)
        slideshow.pageIndicator = nil
        slideshow.currentPageChanged = { [weak self] page in
            self?.pageControl.set(progress: page, animated: true)
          //  self?.timer?.invalidate()
        }
        
        pageControl.tintColor = .white
        pageControl.numberOfPages = promotionBanner?.count ?? 0
    }
    
    @objc func autoScroll() {
        slideshow.nextPage(animated: true)
    }
}
