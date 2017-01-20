//
//  BuscadorViewController.m
//  Cuadros
//
//  Created by Gesfor on 19/01/17.
//  Copyright © 2017 José Cruz Galindo Martínez. All rights reserved.
//

#import "BuscadorViewController.h"
#import "Carrusel-Swift.h"
#import "TVCBuscado.h"
#import "DetalleViewController.h"
#import <MagicalRecord/MagicalRecord.h>

@interface BuscadorViewController () {
  NSArray<Personaje*>* resultado;
}
@end

@implementation BuscadorViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  resultado = [NSArray array];
  _buscadorIn.delegate = self;
  _tableViewResult.dataSource = self;
  _tableViewResult.delegate = self;
  UINib* nib = [UINib nibWithNibName:@"TVCBuscado" bundle:nil];
  [_tableViewResult registerNib:nib forCellReuseIdentifier:@"Identificador"];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.view endEditing:YES];
}


#pragma mark - UITableViewDataSource & Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return resultado.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  TVCBuscado* cell = [tableView dequeueReusableCellWithIdentifier:@"Identificador" forIndexPath:indexPath];
  
  [cell configurar:[resultado objectAtIndex:indexPath.row].nombreCompleto];
//  cell.textLabel.text = [resultado objectAtIndex:indexPath.row].nombreCompleto;
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  Personaje* persona = [resultado objectAtIndex:indexPath.row];
  [self performSegueWithIdentifier:@"mostrarDetalleBio" sender:persona];
}

#pragma mark - UITextFieldDelegate

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//  NSLog(@"Should Change: %@", [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]);
//  
//  return YES;
//}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  Personaje* person = (Personaje*)sender;
  DetalleViewController* controller = (DetalleViewController*)segue.destinationViewController;
  controller.personaje = person;
}

- (IBAction)atras:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buscar:(id)sender {
  [self.view endEditing:YES];
  NSPredicate* predicado;
  NSString* busqueda = _buscadorIn.text;// lowercaseString];
  if (_nombreApellidoSegmented.selectedSegmentIndex == 0) {
    predicado = [NSPredicate predicateWithFormat:@"nombre CONTAINS[cd] %@",busqueda];
  } else {
    predicado = [NSPredicate predicateWithFormat:@"apellidoPaterno CONTAINS[cd] %@",busqueda];
  }
  resultado = [Personaje MR_findAllWithPredicate:predicado];
  NSLog(@"Numero de Resultados: %ld", resultado.count);
  for (Personaje* person in resultado) {
    NSLog(@"%@", person.nombreCompleto);
  }
  [_tableViewResult reloadData];
}

@end
