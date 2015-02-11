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
@property UIImage *blankTileImage;  // tyhjä
@property UIImage *backTileImage;   // kuva
@property NSMutableArray *tiles;    // Taulukko joka sisältää kuvat ja Mutable = voi muuttaa järjestystä
@property NSMutableArray *shuffledTiles; // Taulukko jonka indexit mätsää buttonien tag numeroihin ja numero kertoo kuvan tiles taulukosta
@property NSInteger matchCounter; // Arvatut jotka oikein
@property NSInteger guessCounter; // Arvaukset
@property NSInteger tileFlipped; // sisältää ensimmäisen käännetyn buttonin ID:een ja -1 jos ei ole käännetty vielä
@property UIButton *tile1; // kun painettu ekaa buttonia
@property UIButton *tile2; // kun painettu tokaa buttonia

// private methods
- (void)shuffleTiles;  // sekoittaa kuvat
- (void)resetTiles;     // resetoi kaikki
- (void)gameWon;         // loppu :)

@end

// Implementoidaaan luokka motodit ja muuttujat
// super = call up the hierarcy chain
@implementation GameSceneViewController

// local Boolean
static bool isDisabled = false; // on true, kun tokaa painettu , estetään käyttäjän toimet.
static bool isMatch = false; // jos kuvat on samat niin true

- (void)viewDidLoad {
    [super viewDidLoad]; // same as objc_msgSendSuper(self, @selector(viewDidLoad));
    // Do any additional setup after loading the view.
    self.backTileImage = [UIImage imageNamed:@"back.png"]; // ladataan back kuva
    self.blankTileImage = [UIImage imageNamed:@"blank.png"]; // ladataan tyhjä kuva
    self.tileFlipped = -1; // Ei siis olla käynnistäessä painettu vielä
    self.matchCounter = 0; //
    self.guessCounter = 0; //
    self.gameScoreLabel.text = [NSString stringWithFormat:@"Matches: %d Guesses: %d", self.matchCounter, self.guessCounter]; // labeliin tekstiä
    
    // varataan kuva taulukko ja täytetään se kuvilla
    self.tiles = [[NSMutableArray alloc]initWithObjects:
                  [UIImage imageNamed:@"icons01.png"],
                  [UIImage imageNamed:@"icons01.png"],
                  [UIImage imageNamed:@"icons02.png"],
                  [UIImage imageNamed:@"icons02.png"],
                  [UIImage imageNamed:@"icons03.png"],
                  [UIImage imageNamed:@"icons03.png"],
                  [UIImage imageNamed:@"icons04.png"],
                  [UIImage imageNamed:@"icons04.png"],
                  [UIImage imageNamed:@"icons05.png"],
                  [UIImage imageNamed:@"icons05.png"],
                  [UIImage imageNamed:@"icons06.png"],
                  [UIImage imageNamed:@"icons06.png"],
                  [UIImage imageNamed:@"icons07.png"],
                  [UIImage imageNamed:@"icons07.png"],
                  [UIImage imageNamed:@"icons08.png"],
                  [UIImage imageNamed:@"icons08.png"],
                  [UIImage imageNamed:@"icons09.png"],
                  [UIImage imageNamed:@"icons09.png"],
                  [UIImage imageNamed:@"icons10.png"],
                  [UIImage imageNamed:@"icons10.png"],
                  [UIImage imageNamed:@"icons11.png"],
                  [UIImage imageNamed:@"icons11.png"],
                  [UIImage imageNamed:@"icons12.png"],
                  [UIImage imageNamed:@"icons12.png"],
                  [UIImage imageNamed:@"icons13.png"],
                  [UIImage imageNamed:@"icons13.png"],
                  [UIImage imageNamed:@"icons14.png"],
                  [UIImage imageNamed:@"icons14.png"],
                  [UIImage imageNamed:@"icons15.png"],
                  [UIImage imageNamed:@"icons15.png"],nil
                  ];
    // sekoitetaan . self koska on tässä luokassa
    [self shuffleTiles];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Sekoitus metodi kutsuttu viewdidload
- (void)shuffleTiles
{
    int tileCount = [self.tiles count]; // Paljonko buttoneita
    for (int tileID = 0; tileID < (tileCount/2); tileID++) // luupataan . Täytetään shuffledTiles [0,0,1,1....,14,14]
    {
        [self.shuffledTiles addObject:[NSNumber numberWithInt:tileID]];
        [self.shuffledTiles addObject:[NSNumber numberWithInt:tileID]];
    }
    
    for (NSUInteger i = 0; i < tileCount; ++i) // sekoitetaan numerot
    {
        NSInteger nElements = tileCount - i;
        NSInteger n = (arc4random() % nElements) + i;
        [self.shuffledTiles exchangeObjectAtIndex:i withObjectAtIndex:n];
        [self.tiles exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// impelement tileClicked
// id sisältää buttonin tag arvon joka on syötetty buttoneille välillä 0-29 :)
- (IBAction)tileClicked:(id)sender
{
    if (isDisabled == true) // ei tehdä mitään jos ei just nyt saa
        return;

    // Muuttuja senderID joka sisältää tag arvon buttonista (Ei tarttis, mutta silti):)
    int senderID = [sender tag];
    // debug ikkunaan id
    NSLog(@"Olen Button ja mun ID on: %d\n", senderID);
    
    if (self.tileFlipped >= 0 && senderID != self.tileFlipped) // onko eka button jo painettu ja ei oo painettu samaa
    {
        self.tile2 = sender; // laitetaan tokan buttonin tiedot tile2:een
        // verrataan ekan (self.tileFlipped) kuva osoitetta tokaan (senderID)
        UIImage *lastImage = [self.tiles objectAtIndex: self.tileFlipped];
        UIImage *tileImage = [self.tiles objectAtIndex: senderID];
        
        [sender setImage: tileImage forState:UIControlStateNormal]; // vaihetaan kakkos buttoniin image
        self.guessCounter++; // arvaus +1
        
        if (tileImage.CGImage == lastImage.CGImage) // kuvien osoitteet ==
        {
            [self.tile1 setEnabled:false]; // piilotetaan buttonit
            [self.tile2 setEnabled:false];
            self.matchCounter++;
            isMatch = true; // oli samat
        }
        isDisabled = true; // pitää estää käyttäjää, koska odotetaan että timer laukee. jotta käyttä näkee hetken kuvat jotka ei täsmännyt
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(resetTiles)
                                       userInfo:nil
                                        repeats:NO];
        self.tileFlipped = -1; // jotta osataan taas odottaa ekaa buttonia
        
    }
    else // ei oo vielä painettu tarpeeks
    {
        self.tileFlipped = senderID; // asetetaan eka buttonin ID tileFlipped muuttujaan
        self.tile1 = sender; // ja Buttonin tiedot tile1:een
        UIImage *tileImage = [self.tiles objectAtIndex:senderID]; // haetaan kuvaosote perustuen senderID:en
        [sender setImage: tileImage forState:UIControlStateNormal]; // kuva näkyviin ekaan buttoniin
    }
    
    self.gameScoreLabel.text = [NSString stringWithFormat:@"Matches: %d Guesses: %d", self.matchCounter, self.guessCounter];
    
}

- (void)resetTiles // kutsutaan kun tileClicked timer on juissut loppuun
{
    if (isMatch) // jos true, asetetaan tyhjä, muuten vaihetaan kuva näkyviin
    {
        [self.tile1 setImage: self.blankTileImage forState: UIControlStateNormal];
        [self.tile2 setImage: self.blankTileImage forState: UIControlStateNormal];
    }
    else
    {
        [self.tile1 setImage: self.backTileImage forState: UIControlStateNormal];
        [self.tile2 setImage: self.backTileImage forState: UIControlStateNormal];
    }
    isDisabled = false; // saa taas painella
    isMatch = false; // nollataan "on sama"
    
    if (self.matchCounter == (self.tiles.count/2)) // jos 15 oikeaa jo niin lopetetaan
    {
        [self gameWon];
    }
}

- (void)gameWon // loppu
{
    self.gameScoreLabel.text = [NSString stringWithFormat:@"You won with %d Guesses", self.guessCounter];
}

- (void) viewWillDisappear:(BOOL)animated // kun tämä view object on poistettu niin tätä kutsutaan
{
    [super viewWillDisappear:animated];
}

@end
