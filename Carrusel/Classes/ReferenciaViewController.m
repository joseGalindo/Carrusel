//
//  ReferenciaViewController.m
//  Cuadros
//
//  Created by Gesfor on 14/12/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import "ReferenciaViewController.h"

@interface ReferenciaViewController ()

@end

@implementation ReferenciaViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  _cerrarBtn.layer.cornerRadius = _cerrarBtn.frame.size.width / 2;
  _cerrarBtn.layer.masksToBounds = YES;
  _cerrarBtn.layer.borderColor = [UIColor whiteColor].CGColor;
  _cerrarBtn.layer.borderWidth = 2.0;
  
  NSString* ruta = [[NSBundle mainBundle] pathForResource:@"Referencia" ofType:@"txt"];
  NSError* error;
  NSString* contenido = [NSString stringWithContentsOfFile:ruta encoding:NSUTF8StringEncoding error:&error];
  NSMutableAttributedString* attributtedString = [[NSMutableAttributedString alloc]
                                                  initWithData:[contenido dataUsingEncoding:NSUnicodeStringEncoding]
                                                  options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType}
                                                  documentAttributes:nil
                                                  error:nil];
  //  [attributtedString addAttribute:NSFontAttributeName
  //                            value:[UIFont fontWithName:@"Helvetica" size:28]
  //                            range:NSMakeRange(0, attributtedString.length)];
  _texto.attributedText = attributtedString;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
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


@end
