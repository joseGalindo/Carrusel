//
//  MosaicoViewController.h
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 01/11/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MosaicoViewController : UIViewController <UICollectionViewDataSource,
                                    UICollectionViewDelegate,
                                    UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UIImageView *fondo;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;

@end
