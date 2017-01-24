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
  if (_personaje.sid == 99999) {
    NSString* nombreColor = [NSString stringWithFormat:@"%@Color",_personaje.imagen];
    NSString* nombreGrande = [NSString stringWithFormat:@"%@Grande",_personaje.imagen];
    _imagenBig.image = [UIImage imageNamed:nombreGrande];
    _imagenPersonaje.image = [UIImage imageNamed:nombreColor];
  } else {
    NSLog(@"Sid: %d", _personaje.sid);
  }
  
  _cerrarBtn.layer.cornerRadius = _cerrarBtn.frame.size.width / 2;
  _cerrarBtn.layer.borderWidth = 2;
  _cerrarBtn.layer.borderColor = [UIColor whiteColor].CGColor;
  
  _cerrarZoomBtn.layer.cornerRadius = _cerrarZoomBtn.frame.size.width / 2;
  _cerrarZoomBtn.layer.borderWidth = 2;
  _cerrarZoomBtn.layer.borderColor = [UIColor whiteColor].CGColor;
  
  _retratoView.layer.masksToBounds = NO;
  _retratoView.layer.shadowOffset = CGSizeMake(10, 10);
  _retratoView.layer.shadowRadius = 5.0;
  _retratoView.layer.shadowOpacity = 0.5;
  
  NSString* nombreBio = _personaje.biografia;
  NSError* error;
  NSString *path = [[NSBundle mainBundle] pathForResource:nombreBio ofType:@"txt"];
  NSString* textoBio = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
  if (!error) {
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentJustified;
    NSMutableAttributedString* attributtedString = [[NSMutableAttributedString alloc]
                                                    initWithData:[textoBio dataUsingEncoding:NSUnicodeStringEncoding]
                                                    options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType}
                                                    documentAttributes:nil
                                                    error:nil];
//    [attributtedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attributtedString.length - 1)];
    _biografiaPersonaje.attributedText = attributtedString;
//    _biografiaPersonaje.text = textoBio;
//    [_biografiaPersonaje setFont:[UIFont fontWithName:@"ACaslonPro-Semibold" size:28.0]];
  } else {
    NSLog(@"Error: %@", error.localizedDescription);
  }
  
  // Logs
//  NSLog(@"Caracteres Contenidos");
//  NSLog(@"En Nombre: %ld", _personaje.nombreCompleto.length);
//  CGRect r = [_personaje.nombreCompleto boundingRectWithSize:_nombrePersonaje.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Trajan-Normal" size:40.f]} context:nil];
//  NSLog(@"Rect: %@", NSStringFromCGRect(r));
//  CGSize s = [_personaje.nombreCompleto sizeWithAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Trajan-Normal" size:40.f]}];
//  NSLog(@"Size: %@", NSStringFromCGSize(s));
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
