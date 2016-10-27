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
#import <MagicalRecord/MagicalRecord.h>

@interface ViewController ()

@property NSMutableArray<Cronologica*>* fechasArray;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    _fechasArray = [NSMutableArray array];
    for (NSDictionary* dic in fechas) {
        cronos = [Cronologica MR_createEntity];
        [cronos MR_importValuesForKeysWithObject:dic];
        [_fechasArray addObject:cronos];
    }
    
    [_tablaFechas reloadData];
}

-(void) configurarScrollPersonajes {
//    NSString* ruta = [[NSBundle mainBundle] pathForResource:@"Fechas" ofType:@"json"];
//    NSData* datos = [NSData dataWithContentsOfFile:ruta];
//    NSError* error;
//    NSArray* dates = (NSArray<NSDictionary*>*)[NSJSONSerialization JSONObjectWithData:datos options:NSJSONReadingMutableContainers error:&error];
//    if (error) {
//        NSLog(@"Error: %@", error.localizedDescription);
//    }
//    Personaje* vista;
//    CGRect marco;
//    CGSize tam = [Personaje vistaSize];
//    for (int i = 0; i < 15; i++) {
//        marco = CGRectMake((tam.width + 30) * i, 0, tam.width, tam.height);
//        vista = [[Personaje alloc] initWithFrame:marco];
//        vista.delegado = self;
//        [vista configurarPersonaje:@"plutarco" withNumero:(i + 1)];
//        [_scrollPersonajes addSubview:vista];
//    }
//    
//    _scrollPersonajes.contentSize = CGSizeMake((tam.width + 30) * 15, tam.height);
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
    return 15;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CVCPersonaje* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CVCPersonajes" forIndexPath:indexPath];
    int numInd = (int)(indexPath.row + 1);
    [cell configurarCeldaPersonaje:@"" withNumero:numInd];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CVCPersonaje* person = (CVCPersonaje*)[collectionView cellForItemAtIndexPath:indexPath];
    person.vistaOpaca.hidden = YES;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    CVCPersonaje* person = (CVCPersonaje*)[collectionView cellForItemAtIndexPath:indexPath];
    person.vistaOpaca.hidden = NO;
}

#pragma mark Configuracion Vista Personaje

-(void) configurarVistaPersonaje:(NSString*) nombre withNumero:(int) numero andFoto:(NSString*) filePath {
    _numeroSelected.text = [NSString stringWithFormat:@"%d", numero];
}

@end
