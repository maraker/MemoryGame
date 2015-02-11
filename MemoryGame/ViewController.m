//
//  ViewController.m
//  MemoryGame
//
//  Created by Markku Åkerfelt on 09/02/15.
//  Copyright (c) 2015 Markku Åkerfelt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Lisätään Action Exit buttonille jotta päästään takas.
- (IBAction)unwindTothisViewController:(UIStoryboardSegue *)unwindSeque
{
    
}

@end
