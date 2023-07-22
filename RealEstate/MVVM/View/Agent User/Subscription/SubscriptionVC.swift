//
//  SubscriptionVC.swift
//  RealEstate
//
//  Created by jass Dhariwal on 07/07/23.
//

import UIKit

class SubscriptionVC: UIViewController {

    
    @IBOutlet weak var crousalView: UICollectionView!
    // MARK: - Properties (Private)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        crousalView.registerNib(cell: SubscriptionClcCell.self)
        crousalView.delegate = self
        crousalView.dataSource = self
        
//        let carouselFlowLayout = CarouselFlowLayout()
//        carouselFlowLayout.scalingOffset = 400//crousalView.frame.height
//        crousalView.collectionViewLayout = carouselFlowLayout

        let layout = UPCarouselFlowLayout()
        layout.spacingMode = .overlap(visibleOffset: 20)
        layout.scrollDirection = .horizontal
//        layout
        layout.itemSize = CGSize(width: crousalView.frame.width - 60, height: crousalView.frame.height)
        crousalView.collectionViewLayout = layout
    }
    
    @IBAction func btnBackAction(_ sender: UIButton){
        self.popVc()
    }

}
extension SubscriptionVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubscriptionClcCell.identifier, for: indexPath) as! SubscriptionClcCell

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.push(PaymentScreenVC.getVC(.Subscription))

    }
    
    

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.crousalView.frame.width - 100, height: self.crousalView.frame.height - 10.0)
//    }
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        guard let cell = crousalView.visibleCells.last else {return}
//        guard let index = crousalView.indexPath(for: cell) else {return}
//        self.crousalView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
//
//    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

class CarouselFlowLayout: UICollectionViewFlowLayout {
    var scalingOffset: CGFloat = 200
    let minimumScaleFactor: CGFloat = 0.8
    
    override func prepare() {
        super.prepare()
        
        scrollDirection = .horizontal
        itemSize = CGSize(width: collectionView!.bounds.width * 0.7, height: collectionView!.bounds.height * 0.7)
        minimumLineSpacing = 20
        
        let horizontalInset = (collectionView!.bounds.width - itemSize.width) / 2
        let verticalInset = (collectionView!.bounds.height - itemSize.height) / 2
        sectionInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
              let collectionView = collectionView else {
            return nil
        }
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        
        for attributes in superAttributes {
            let distance = visibleRect.midX - attributes.center.x
            let normalizedDistance = distance / scalingOffset
            
            if abs(distance) < scalingOffset {
                let scale = 1 - minimumScaleFactor * abs(normalizedDistance)
                attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
                attributes.zIndex = Int(scale * 10)
            }
        }
        
        return superAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let proposedRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
        
        guard let attributes = layoutAttributesForElements(in: proposedRect),
              let firstAttribute = attributes.first else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let targetCenterX = proposedContentOffset.x + collectionView.bounds.width / 2
        let closestAttribute = attributes.reduce(firstAttribute) { closest, attribute in
            let closestDistance = abs(closest.center.x - targetCenterX)
            let attributeDistance = abs(attribute.center.x - targetCenterX)
            return attributeDistance < closestDistance ? attribute : closest
        }
        
        let targetX = closestAttribute.center.x - collectionView.bounds.width / 2
        return CGPoint(x: targetX, y: proposedContentOffset.y)
    }
    
    func scrollToItem(atIndex index: Int, animated: Bool) {
        guard let collectionView = collectionView,
              index >= 0 && index < collectionView.numberOfItems(inSection: 0) else {
            return
        }
        
        let indexPath = IndexPath(item: index, section: 0)
        let attributes = layoutAttributesForItem(at: indexPath)
        let targetX = attributes?.frame.origin.x ?? 0
        
        collectionView.setContentOffset(CGPoint(x: targetX, y: 0), animated: animated)
    }
}

