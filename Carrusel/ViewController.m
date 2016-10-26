//
//  ViewController.m
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import "ViewController.h"
#import "HeaderFecha.h"
#import "Personaje.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize scrollFechas = _scrollFechas;
@synthesize scrollPersonajes = _scrollPersonajes;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configurarScrollFechas];
    [self configurarScrollPersonajes];
    
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
    
    HeaderFecha* vista;
    CGRect marco;
    int posicion = 0;
    CGSize tam = [HeaderFecha vistaSize];
    for (NSDictionary* dicc in fechas) {
        marco = CGRectMake(0, tam.height * posicion, tam.width, tam.height);
        vista = [[HeaderFecha alloc] initWithFrame:marco];
        [vista configurarVista:[dicc objectForKey:@"Fecha"] withTitulo:[dicc objectForKey:@"titulo"]];
        [_scrollFechas addSubview:vista];
        posicion++;
    }
    
    _scrollFechas.contentSize = CGSizeMake(tam.width, tam.height * fechas.count);
}

-(void) configurarScrollPersonajes {
//    NSString* ruta = [[NSBundle mainBundle] pathForResource:@"Fechas" ofType:@"json"];
//    NSData* datos = [NSData dataWithContentsOfFile:ruta];
//    NSError* error;
//    NSArray* dates = (NSArray<NSDictionary*>*)[NSJSONSerialization JSONObjectWithData:datos options:NSJSONReadingMutableContainers error:&error];
//    if (error) {
//        NSLog(@"Error: %@", error.localizedDescription);
//    }
    Personaje* vista;
    CGRect marco;
    CGSize tam = [Personaje vistaSize];
    for (int i = 0; i < 15; i++) {
        marco = CGRectMake((tam.width + 30) * i, 0, tam.width, tam.height);
        vista = [[Personaje alloc] initWithFrame:marco];
        [vista configurarPersonaje:@"plutarco" withNumero:(i + 1)];
        [_scrollPersonajes addSubview:vista];
    }
    
    _scrollPersonajes.contentSize = CGSizeMake((tam.width + 30) * 15, tam.height);
}

@end
