//
//  GameSceneViewController.m
//  MemoryGame
//
//  Created by Markku Åkerfelt on 11/02/15.
//  Copyright (c) 2015 Markku Åkerfelt. All rights reserved.
//

#import "GameSceneViewController.h"

// Määritellään luokka
@interface GameSceneViewController ()

// Tähän private muuttujat, propertiessit ja motodit.

@end

// Implementoidaaan luokka motodit ja muuttujat
// super = call up the hierarcy chain
@implementation GameSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad]; // same as objc_msgSendSuper(self, @selector(viewDidLoad));
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
