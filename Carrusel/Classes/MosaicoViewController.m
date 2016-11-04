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
#import "DetalleViewController.h"
#import <MagicalRecord/MagicalRecord.h>

@interface MosaicoViewController ()
    @property Personaje* personajeActual;
@end

static NSString* REUSE_IDENTIFIER = @"Cell_Reuse_Identifier";

@implementation MosaicoViewController {
    CAGradientLayer* capaBandera;
    NSMutableArray* personajesArray;
    NSIndexPath* selectedIndexPath;
    BOOL filtroNombresShowed;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Gradiente
//    capaBandera = [[CAGradientLayer alloc] init];
//    capaBandera.frame = _fondo.frame;
//    capaBandera.colors = [NSArray arrayWithObjects:
//                          (id)[UIColor colorWithRed:(7.0/255.0) green:(100.0/255.0) blue:(26.0/255.0) alpha:1].CGColor,
//                          (id)[UIColor whiteColor].CGColor,
//                          (id)[UIColor colorWithRed:(179.0/255.0) green:0 blue:(16.0/255.0) alpha:1].CGColor, nil];
//    capaBandera.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
//                             [NSNumber numberWithFloat:0.5],
//                             [NSNumber numberWithFloat:1.0], nil];
//    capaBandera.startPoint = CGPointMake(0, 0.0);
//    capaBandera.endPoint = CGPointMake(1.0, 1.0);
//    [_fondo.layer addSublayer:capaBandera];

    
    // Mosaico de imagenes
    _mCollectionView.dataSource = self;
    _mCollectionView.delegate = self;
    UINib* nib = [UINib nibWithNibName:@"CVCPersonajeSimple" bundle:nil];
    [_mCollectionView registerNib:nib forCellWithReuseIdentifier:REUSE_IDENTIFIER];
    
    [self configurarPersonajes];
    
    // Tabla de Nombres
    _tablaNombres.dataSource = self;
    _tablaNombres.delegate = self;
    _tablaNombres.alpha = 0;
    _tablaNombres.hidden = YES;
    filtroNombresShowed = NO;
    
    
    // Configuramos el popUp
    _popUpView.hidden = YES;
    _popUpView.alpha = 0.f;
    _cerrarBorderBtn.layer.cornerRadius = _cerrarBorderBtn.frame.size.width / 2;
    _cerrarBorderBtn.layer.masksToBounds = YES;
    _cerrarBorderBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _cerrarBorderBtn.layer.borderWidth = 2.0f;
    
    _vistaBioContainer.layer.cornerRadius = 10;
    _vistaBioContainer.layer.masksToBounds = YES;
    
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

-(void) configurarPopUp {
    _nombrePopUp.text = _personajeActual.nombre;
    _imagenPopUp.image = [UIImage imageNamed:_personajeActual.imagen ];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    //NSLog(@"Vista: %@", NSStringFromCGRect(_fondo.frame));
    //NSLog(@"Will View: %@", NSStringFromCGSize(size));
//    capaBandera.frame = CGRectMake(0, 0, size.width, size.height);
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    DetalleViewController* controller = (DetalleViewController*)segue.destinationViewController;
    controller.personaje = _personajeActual;
}

#pragma mark - UITableView DataSource & Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return personajesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* celda = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"ReuseIdentifier_%ld", indexPath.row]];
    
    Personaje* persona = [personajesArray objectAtIndex:indexPath.row];
    celda.textLabel.font = [UIFont fontWithName:@"Trajan-Normal" size:25.f];
    celda.textLabel.text = persona.nombre;
    celda.textLabel.textColor = [UIColor whiteColor];
    UIView* bg = [[UIView alloc] initWithFrame:celda.frame];
    bg.backgroundColor = [UIColor blackColor];
    bg.alpha = 0.5;
    celda.backgroundView = bg;
    return celda;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



#pragma mark - UICollectionView DataSource & Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return personajesArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CVCPersonajeSimple* cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER forIndexPath:indexPath];
    
    Personaje* persona = [personajesArray objectAtIndex:indexPath.row];
    [cell configurarCelda:persona.imagen];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CVCPersonajeSimple* cell = (CVCPersonajeSimple*)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
        _personajeActual = [personajesArray objectAtIndex:indexPath.row];
        [self configurarPopUp];
        CGRect marcoNuevo = cell.frame;
        marcoNuevo.size = CGSizeMake(192, 258);
        _popUpView.hidden = NO;
        [UIView animateWithDuration:1 animations:^{
            _popUpView.alpha = 1;
        }];
        //[cell seleccionarPersonaje];
        /*[UIView animateWithDuration:0.2 animations:^{
            cell.frame = marcoNuevo;
            [collectionView.collectionViewLayout invalidateLayout];
        } completion:^(BOOL finished) {
            selectedIndexPath = indexPath;
            [collectionView.collectionViewLayout invalidateLayout];
        }];*/
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    CVCPersonajeSimple* cell = (CVCPersonajeSimple*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell deseleccionarPersonaje];
    _personajeActual = nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (selectedIndexPath && [selectedIndexPath isEqual:indexPath]) {
        return CGSizeMake(192, 258);
    } else {
        return CGSizeMake(128, 170);
    }
}

#pragma mark - IBActions

- (IBAction)cerrarPopUp:(id)sender {
    [UIView animateWithDuration:1 animations:^{
        _popUpView.alpha = 0;
    } completion:^(BOOL finished) {
        _popUpView.hidden = YES;
    }];
}

- (IBAction)mostrarDetalle:(id)sender {
    [self performSegueWithIdentifier:@"mostrarDetalle" sender:self];
}

- (IBAction)mostrarFiltroNombres:(id)sender {
    if (filtroNombresShowed) {
        [UIView animateWithDuration:0.5 animations:^{
            _tablaNombres.alpha = 0.f;
        } completion:^(BOOL finished) {
            _tablaNombres.hidden = YES;
        }];
        [_mCollectionView setUserInteractionEnabled:YES];
    } else {
        _tablaNombres.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _tablaNombres.alpha = 1.f;
        }];
        [_mCollectionView setUserInteractionEnabled:NO];
    }
    
    filtroNombresShowed = !filtroNombresShowed;
}


@end
