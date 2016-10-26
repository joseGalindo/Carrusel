//
//  ViewController.m
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize scrollFechas = _scrollFechas;
@synthesize scrollPersonajes = _scrollPersonajes;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* ruta = [[NSBundle mainBundle] pathForResource:@"Fechas" ofType:@"json"];
    NSData* datos = [NSData dataWithContentsOfFile:ruta];
    NSError* error;
    NSArray* dates = (NSArray*)[NSJSONSerialization JSONObjectWithData:datos options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
    for (NSDictionary* dic  in dates) {
        NSLog(@"Fecha: %@", [dic objectForKey:@"Fecha"]);
    }
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
