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
                                    UICollectionViewDelegateFlowLayout,
 UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *tablaNombres;

// Popup View
@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UIImageView *imagenPopUp;
@property (weak, nonatomic) IBOutlet UILabel *nombrePopUp;
@property (weak, nonatomic) IBOutlet UIButton *cerrarBorderBtn;
@property (weak, nonatomic) IBOutlet UIView *vistaBioContainer;


- (IBAction)cerrarPopUp:(id)sender;
- (IBAction)mostrarDetalle:(id)sender;
- (IBAction)mostrarFiltroNombres:(id)sender;

@end
