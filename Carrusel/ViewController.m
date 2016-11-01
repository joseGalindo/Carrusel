//
//  ViewController.m
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import "ViewController.h"
#import "HeaderFecha.h"
#import "TVCFecha.h"
#import "CVCPersonaje.h"
#import "Carrusel-Swift.h"
#import "DetalleViewController.h"
#import <MagicalRecord/MagicalRecord.h>

@interface ViewController ()

@property NSMutableArray<Cronologica*>* fechasArray;
@property NSMutableArray<Personaje*>* personajesArray;
@property Personaje* personajeActual;

@end

@implementation ViewController {
    int posicionActual;
    NSTimer* animarCarrusel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prefersStatusBarHidden];
    
    _fechasArray = [NSMutableArray array];
    _personajesArray = [NSMutableArray array];
    [self configurarScrollFechas];
    [self configurarScrollPersonajes];
    
    UINib* nibTabla = [UINib nibWithNibName:@"TVCFecha" bundle:nil];
    [_tablaFechas registerNib:nibTabla forCellReuseIdentifier:@"TVCFechas"];
    _tablaFechas.dataSource = self;
    _tablaFechas.delegate = self;
    
    UINib* nibColection = [UINib nibWithNibName:@"CVCPersonaje" bundle:nil];
    [_collectionPersonajes registerNib:nibColection forCellWithReuseIdentifier:@"CVCPersonajes"];
    _collectionPersonajes.dataSource = self;
    _collectionPersonajes.delegate = self;
    
    _vistaMiniDetalle.layer.masksToBounds = NO;
    _vistaMiniDetalle.layer.shadowOffset = CGSizeMake(5, 5);
    _vistaMiniDetalle.layer.shadowRadius = 5;
    _vistaMiniDetalle.layer.shadowOpacity = 0.5;
    
    posicionActual = 10;
    animarCarrusel = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cambiarFocoCollection) userInfo:nil repeats:YES];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    // Gradiente
    CAGradientLayer* capaBandera = [[CAGradientLayer alloc] init];
    capaBandera.frame = self.view.frame;
    capaBandera.colors = [NSArray arrayWithObjects:
                          (id)[UIColor colorWithRed:(7.0/255.0) green:(100.0/255.0) blue:(26.0/255.0) alpha:0.5].CGColor,
                          (id)[UIColor whiteColor].CGColor,
                          (id)[UIColor colorWithRed:(179.0/255.0) green:0 blue:(16.0/255.0) alpha:0.5].CGColor, nil];
    capaBandera.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
                             [NSNumber numberWithFloat:0.5],
                             [NSNumber numberWithFloat:1.0], nil];
    capaBandera.startPoint = CGPointMake(0, 0.4);
    capaBandera.endPoint = CGPointMake(1.0, 1.0);
    
    
    [_fondo.layer addSublayer:capaBandera];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) configurarScrollFechas {
    NSString* ruta = [[NSBundle mainBundle] pathForResource:@"Fechas" ofType:@"json"];
    NSData* datos = [NSData dataWithContentsOfFile:ruta];
    NSError* error;
    NSArray* fechas = (NSArray<NSDictionary*>*)[NSJSONSerialization JSONObjectWithData:datos options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
    Cronologica* cronos;
    for (NSDictionary* dic in fechas) {
        cronos = [Cronologica MR_createEntity];
        [cronos MR_importValuesForKeysWithObject:dic];
        [_fechasArray addObject:cronos];
    }
    
    [_tablaFechas reloadData];
}

-(void) configurarScrollPersonajes {
    NSString* ruta = [[NSBundle mainBundle] pathForResource:@"Personajes" ofType:@"json"];
    NSData* datos = [NSData dataWithContentsOfFile:ruta];
    NSError* error;
    NSArray* personalities = (NSArray<NSDictionary*>*)[NSJSONSerialization JSONObjectWithData:datos options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
    
    Personaje* person;
    for (NSDictionary* dic in personalities) {
        person = [Personaje MR_createEntity];
        [person MR_importValuesForKeysWithObject:dic];
        [_personajesArray addObject:person];
    }
    
    [_collectionPersonajes reloadData];
    NSIndexPath* indice = [NSIndexPath indexPathForRow:0 inSection:0];
    //[_collectionPersonajes selectItemAtIndexPath:indice animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    [self collectionView:_collectionPersonajes didSelectItemAtIndexPath:indice];
}

-(void) cambiarFocoCollection {
    [_collectionPersonajes scrollToItemAtIndexPath:
     [NSIndexPath indexPathForRow:posicionActual inSection:0]
                                  atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                          animated:YES];
    posicionActual = (posicionActual + 3) % _personajesArray.count;
}

- (void)deviceDidRotate:(NSNotification *)notification
{
    UIDeviceOrientation orientacion = [[UIDevice currentDevice] orientation];
    
    BOOL isLandscape = UIDeviceOrientationIsLandscape(orientacion);
    BOOL isPortrait = UIDeviceOrientationIsPortrait(orientacion);
    
    if (isPortrait) {
        _numeroBottomConstraint.constant = 600.0;
        _fechaBottomConstraint.constant = 600.0;
    }
    
    if (isLandscape) {
        _numeroBottomConstraint.constant = 40.0;
        _fechaBottomConstraint.constant = 40.0;
    }
}

#pragma mark - UITableView Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _fechasArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TVCFecha* cell = [tableView dequeueReusableCellWithIdentifier:@"TVCFechas" forIndexPath:indexPath];
    Cronologica* cronol = [_fechasArray objectAtIndex:indexPath.row];
    
    [cell configurarCelda:cronol];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TVCFecha vistaHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TVCFecha* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.fondo.backgroundColor = [UIColor darkGrayColor];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    TVCFecha* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.fondo.backgroundColor = [UIColor colorWithRed:(107.0 / 255.0)
                                                 green:(100.0 / 255.0)
                                                  blue:(95.0 / 255.0) alpha:1.0];
}

#pragma mark - UICollectionView Methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _personajesArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CVCPersonaje* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CVCPersonajes" forIndexPath:indexPath];
    Personaje* person = [_personajesArray objectAtIndex:indexPath.row];
    [cell configurarCeldaPersonaje:person];
    //int numInd = (int)(indexPath.row + 1);
    //[cell configurarCeldaPersonaje:@"" withNumero:numInd];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CVCPersonaje* person = (CVCPersonaje*)[collectionView cellForItemAtIndexPath:indexPath];
    person.vistaOpaca.hidden = YES;
    Personaje* persona = [_personajesArray objectAtIndex:indexPath.row];
    _personajeActual = persona;
    posicionActual = (int)indexPath.row;
    [self configurarVistaPersonaje:persona];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    CVCPersonaje* person = (CVCPersonaje*)[collectionView cellForItemAtIndexPath:indexPath];
    person.vistaOpaca.hidden = NO;
}

#pragma mark Configuracion Vista Personaje

-(void) configurarVistaPersonaje:(Personaje*) personaje {
    _numeroSelected.text = [NSString stringWithFormat:@"%d", personaje.posicion];
    _nombreSelected.text = personaje.nombre;
    _imagenPersonajeSelected.image = [UIImage imageNamed:personaje.imagen];
}

#pragma mark Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[DetalleViewController class]]) {
        DetalleViewController* controller = (DetalleViewController*)segue.destinationViewController;
        controller.personaje = _personajeActual;
    }
}



- (IBAction)cambiarEfecto:(id)sender {
    
}


- (IBAction)setSlide:(id)sender {
    NSLog(@"Cambiar efecto");
    if (_switchAnimacion.on) {
        NSLog(@"Switch On");
        animarCarrusel = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cambiarFocoCollection) userInfo:nil repeats:YES];
    } else {
        [animarCarrusel invalidate];
        animarCarrusel = nil;
        NSLog(@"Switch Off");
    }
}


@end
