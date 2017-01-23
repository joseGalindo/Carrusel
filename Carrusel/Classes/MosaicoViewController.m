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
  NSArray* personajesArray;
  NSArray* personajesSort;
  Personaje* extraCobian;
  NSIndexPath* selectedIndexPath;
  BOOL filtroNombresShowed;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Mosaico de imagenes
  _mCollectionView.dataSource = self;
  _mCollectionView.delegate = self;
  UINib* nib = [UINib nibWithNibName:@"CVCPersonajeSimple" bundle:nil];
  [_mCollectionView registerNib:nib forCellWithReuseIdentifier:REUSE_IDENTIFIER];
  
  personajesArray = [NSArray array];
  personajesSort = [NSArray array];
  
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

-(void)viewWillAppear:(BOOL)animated {
  [self configurarPersonajes];
}

-(void) configurarPersonajes {
  personajesArray = [Personaje MR_findAllSortedBy:@"posicion" ascending:YES];
  
  // Cobian
//  NSString* ruta = [[NSBundle mainBundle] pathForResource:@"Cobian" ofType:@"json"];
//  NSData* datos = [NSData dataWithContentsOfFile:ruta];
//  NSError* error;
//  id jsonCobian = [NSJSONSerialization JSONObjectWithData:datos options:NSJSONReadingMutableContainers error:&error];
//  if (error) {
//    NSLog(@"Error: %@", error.localizedDescription);
//  }
//  extraCobian = [Personaje MR_importFromObject:jsonCobian];
  
  [_mCollectionView reloadData];
  
  personajesSort = [Personaje MR_findAllSortedBy:@"apellidoPaterno" ascending:YES];
  [_tablaNombres reloadData];
}

-(void) configurarPopUp {
  _nombrePopUp.text = _personajeActual.nombreCompleto;
  _imagenPopUp.image = [UIImage imageNamed:_personajeActual.imagen];
  _fechasPopUp.text = _personajeActual.periodo;
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  if ([segue.destinationViewController isKindOfClass:[DetalleViewController class]]) {
    DetalleViewController* controller = (DetalleViewController*)segue.destinationViewController;
    controller.personaje = _personajeActual;
  } else {
    // TODO: Mandar la fecha seleccionada
  }
  
}

#pragma mark - UITableView DataSource & Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return personajesSort.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell* celda = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"ReuseIdentifier_%ld", indexPath.row]];
  
  Personaje* persona = [personajesSort objectAtIndex:indexPath.row];
  celda.textLabel.font = [UIFont fontWithName:@"Trajan-Normal" size:25.f];
  NSString* nombre;
  if ([persona.apellidoMaterno isEqualToString:@""]) {
    nombre = [NSString stringWithFormat:@"%@, %@",
              persona.apellidoPaterno,
              persona.nombre];
  } else {
    nombre = [NSString stringWithFormat:@"%@ %@, %@",
              persona.apellidoPaterno,
              persona.apellidoMaterno,
              persona.nombre];
  }
  celda.textLabel.text = nombre;
  celda.textLabel.textColor = [UIColor whiteColor];
  
  celda.backgroundColor = [UIColor clearColor];
  return celda;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  Personaje* persona = [personajesSort objectAtIndex:indexPath.row];
  _personajeActual = persona;
  [self performSegueWithIdentifier:@"mostrarDetalle" sender:self];
  [self mostrarFiltroNombres:FALSE];
}

#pragma mark - UICollectionView DataSource & Delegate

//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//  return 2;
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//  if (section == 0) {
    return personajesArray.count;
//  } else {
//    return 1;
//  }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  CVCPersonajeSimple* cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER forIndexPath:indexPath];
  Personaje* persona;// = [personajesArray objectAtIndex:indexPath.row];
//  if (indexPath.section == 0) {
    persona = [personajesArray objectAtIndex:indexPath.row];
//  } else {
//    persona = extraCobian;
//  }
  [cell configurarCelda:persona];
  
  return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  CVCPersonajeSimple* cell = (CVCPersonajeSimple*)[collectionView cellForItemAtIndexPath:indexPath];
  if (cell) {
    _personajeActual = [personajesArray objectAtIndex:indexPath.row];
    [self configurarPopUp];
    _popUpView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
      _popUpView.alpha = 1;
    }];
  }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
  //CVCPersonajeSimple* cell = (CVCPersonajeSimple*)[collectionView cellForItemAtIndexPath:indexPath];
  _personajeActual = nil;
}

/*
 -(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
 if (selectedIndexPath && [selectedIndexPath isEqual:indexPath]) {
 return CGSizeMake(192, 255);
 } else {
 return CGSizeMake(128, 170);
 }
 }
 */

#pragma mark - IBActions

- (IBAction)cerrarPopUp:(id)sender {
  [UIView animateWithDuration:0.5 animations:^{
    _popUpView.alpha = 0;
  } completion:^(BOOL finished) {
    _popUpView.hidden = YES;
  }];
}

- (IBAction)mostrarDetalle:(id)sender {
  [self performSegueWithIdentifier:@"mostrarDetalle" sender:self];
}

- (IBAction)mostrarFiltroNombres:(id)sender {
  //_tablaNombres
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

- (IBAction)mostrarFiltroFechas:(id)sender {
  [self performSegueWithIdentifier:@"mostrarCarrusel" sender:self];
}


@end
