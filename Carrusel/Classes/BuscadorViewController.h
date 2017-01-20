//
//  BuscadorViewController.h
//  Cuadros
//
//  Created by Gesfor on 19/01/17.
//  Copyright © 2017 José Cruz Galindo Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuscadorViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *buscadorIn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *nombreApellidoSegmented;
@property (weak, nonatomic) IBOutlet UITableView *tableViewResult;

- (IBAction)atras:(id)sender;
- (IBAction)buscar:(id)sender;

@end
