//
//  GameSceneViewController.h
//  MemoryGame
//
//  Created by Markku Åkerfelt on 11/02/15.
//  Copyright (c) 2015 Markku Åkerfelt. All rights reserved.
//

// UIKit framework. Saadaan storyboard näkyviin luokalle
#import <UIKit/UIKit.h>

// Esitellään luokka UIViewController luokan alle, laajennetaan UIViewController luokkaa
@interface GameSceneViewController : UIViewController

// Tähän voi laittaa public muuttujien ja publin metodien esittely.
// Public Buttonviews outlet collection ctrl+drag to here
// in left dotted circle mean; your button is linked.
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonviews;
// Peli score label connector
@property (strong, nonatomic) IBOutlet UILabel *gameScoreLabel;

// Luodaan public Action storeboard metodi joka toteutuu kun korttia (button) painetaan
- (IBAction)tileClicked:(id)sender;


@end
