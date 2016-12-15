//
//  ReferenciaViewController.h
//  Cuadros
//
//  Created by Gesfor on 14/12/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReferenciaViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *cerrarBtn;
@property (weak, nonatomic) IBOutlet UITextView *texto;

- (IBAction)cerrar:(id)sender;

@end
