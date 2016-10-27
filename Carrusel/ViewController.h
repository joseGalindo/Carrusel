//
//  ViewController.h
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonajesProtocol.h"

@interface ViewController : UIViewController <
                            UITableViewDelegate, UITableViewDataSource,
                            UICollectionViewDelegate, UICollectionViewDataSource>

// UI
@property (weak, nonatomic) IBOutlet UITableView *tablaFechas;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionPersonajes;
@property (weak, nonatomic) IBOutlet UIView *vistaMiniDetalle;

// Vista Detalle
@property (weak, nonatomic) IBOutlet UILabel *numeroSelected;
@property (weak, nonatomic) IBOutlet UILabel *nombreSelected;
@property (weak, nonatomic) IBOutlet UILabel *fechaPersonajeSelected;
@property (weak, nonatomic) IBOutlet UIImageView *imagenPersonajeSelected;


@end

