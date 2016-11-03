//
//  MosaicoViewController.m
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 01/11/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import "MosaicoViewController.h"
#import "CVCPersonajeSimple.h"
#import "Carrusel-Swift.h"
#import <MagicalRecord/MagicalRecord.h>

@interface MosaicoViewController ()

@end

static NSString* REUSE_IDENTIFIER = @"Cell_Reuse_Identifier";

@implementation MosaicoViewController {
    CAGradientLayer* capaBandera;
    NSMutableArray* personajesArray;
    NSIndexPath* selectedIndexPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Gradiente
    capaBandera = [[CAGradientLayer alloc] init];
    capaBandera.frame = _fondo.frame;
    capaBandera.colors = [NSArray arrayWithObjects:
                          (id)[UIColor colorWithRed:(7.0/255.0) green:(100.0/255.0) blue:(26.0/255.0) alpha:1].CGColor,
                          (id)[UIColor whiteColor].CGColor,
                          (id)[UIColor colorWithRed:(179.0/255.0) green:0 blue:(16.0/255.0) alpha:1].CGColor, nil];
    capaBandera.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
                             [NSNumber numberWithFloat:0.5],
                             [NSNumber numberWithFloat:1.0], nil];
    capaBandera.startPoint = CGPointMake(0, 0.0);
    capaBandera.endPoint = CGPointMake(1.0, 1.0);
    [_fondo.layer addSublayer:capaBandera];

    _mCollectionView.dataSource = self;
    _mCollectionView.delegate = self;
    UINib* nib = [UINib nibWithNibName:@"CVCPersonajeSimple" bundle:nil];
    [_mCollectionView registerNib:nib forCellWithReuseIdentifier:REUSE_IDENTIFIER];
    
    [self configurarPersonajes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) configurarPersonajes {
    NSString* ruta = [[NSBundle mainBundle] pathForResource:@"Personajes" ofType:@"json"];
    NSData* datos = [NSData dataWithContentsOfFile:ruta];
    NSError* error;
    NSArray* personalities = (NSArray<NSDictionary*>*)[NSJSONSerialization JSONObjectWithData:datos options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
    
    Personaje* person;
    personajesArray = [NSMutableArray array];
    for (NSDictionary* dic in personalities) {
        person = [Personaje MR_createEntity];
        [person MR_importValuesForKeysWithObject:dic];
        [personajesArray addObject:person];
    }
    
    [_mCollectionView reloadData];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    //NSLog(@"Vista: %@", NSStringFromCGRect(_fondo.frame));
    //NSLog(@"Will View: %@", NSStringFromCGSize(size));
    capaBandera.frame = CGRectMake(0, 0, size.width, size.height);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return personajesArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CVCPersonajeSimple* cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER forIndexPath:indexPath];
    
    Personaje* persona = [personajesArray objectAtIndex:indexPath.row];
    [cell configurarCelda:persona.imagen];
    //[cell deseleccionarPersonaje];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CVCPersonajeSimple* cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER forIndexPath:indexPath];
    if (cell) {
        CGRect marcoNuevo = cell.frame;
        marcoNuevo.size = CGSizeMake(192, 258);
        [cell seleccionarPersonaje];
        [UIView animateWithDuration:0.3 animations:^{
            cell.frame = marcoNuevo;
            [collectionView.collectionViewLayout invalidateLayout];
        } completion:^(BOOL finished) {
            selectedIndexPath = indexPath;
            [collectionView.collectionViewLayout invalidateLayout];
        }];
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (selectedIndexPath && [selectedIndexPath isEqual:indexPath]) {
        return CGSizeMake(192, 258);
    } else {
        return CGSizeMake(128, 170);
    }
}

@end
