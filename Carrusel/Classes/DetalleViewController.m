//
//  DetalleViewController.m
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import "DetalleViewController.h"
#import "Carrusel-Swift.h"

@interface DetalleViewController ()
@end

@implementation DetalleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imagenPersonaje.image = [UIImage imageNamed:_personaje.imagen];
    _nombrePersonaje.text = _personaje.nombreCompleto;
    _imagenBig.image = [UIImage imageNamed:_personaje.imagen];
    
    _cerrarBtn.layer.cornerRadius = _cerrarBtn.frame.size.width / 2;
    _cerrarBtn.layer.borderWidth = 2;
    _cerrarBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    NSString* nombreBio = _personaje.biografia;
    NSError* error;
    NSString *path = [[NSBundle mainBundle] pathForResource:nombreBio ofType:@"txt"];
    NSString* textoBio = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (!error) {
        _biografiaPersonaje.text = textoBio;
    } else {
        NSLog(@"Error: %@", error.localizedDescription);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated {
    [_biografiaPersonaje scrollRangeToVisible:(NSMakeRange(0, 0))];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cerrar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)mostrarZoom:(id)sender {
    _zoomView.alpha = 0;
    _zoomView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _zoomView.alpha = 1;
    }];
}

- (IBAction)cerrarZoom:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        _zoomView.alpha = 0;
    } completion:^(BOOL finished) {
        _zoomView.hidden = YES;
    }];
}

@end
