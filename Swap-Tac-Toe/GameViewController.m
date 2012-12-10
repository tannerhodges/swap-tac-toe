//
//  GameViewController.m
//  Swap-Tac-Toe
//
//  Created by Tanner Hodges on 11/26/12.
//  Copyright (c) 2012 Tanner Hodges. All rights reserved.
//

#import "GameViewController.h"

// Define fancy shortcodes
// #define f(x) [NSNumber numberWithFloat:x]

@implementation GameViewController

// Synthesize properties
@synthesize gridValues, statusLabel;

// Global variables
NSString *playerCharacter = @"-";
int gridSize = 3;

// Game variables
bool gameOver = false;
NSString *winner = @"The Cat";
int turn = 0;



-(void)viewDidLoad {
    // Make sure we get everything from the super method
    [super viewDidLoad];
    
    statusLabel.text = @"X, you go first";
    
    // Setup game
    [self resetGame];
}



-(void)resetGame {
    gameOver = false;
    turn = 0;
    
    [self initGridArray];
    [self setupGrid];
}



-(void)initGridArray {
    // Create columns
    gridValues = [NSMutableArray arrayWithCapacity:gridSize];
    
    // Create rows
    for(int x=0; x<gridSize; x++)
        [gridValues insertObject:[NSMutableArray arrayWithCapacity:gridSize] atIndex:x];
    
    // Initialize cells
//    int index=0;
    for(int y=0; y<gridSize; y++) { // Remember to loop from the outside in!
        for(int x=0; x<gridSize; x++) {
            [gridValues[x] insertObject:[NSString stringWithFormat:@""] atIndex:y];
//            index++;
        }
    }
    
    NSLog(@"Cell values in gridValues: %@",gridValues);
}



-(void)setupGrid {
    // Grid parameters
    int buttonSize = self.view.frame.size.width / 5;
    int padding = 5;
    
    // Dynamic variables for grid size and position
    int totalGridSize = (buttonSize*gridSize)+(padding*(gridSize-1));
    float centerX = (self.view.frame.size.width/2)-(totalGridSize/2);
//    float centerY = (self.view.frame.size.height/2)-(totalGridSize/2);
    float centerY = 100;
    
    /*  // Get a crosshair on that center
     UIButton *temp = [[UIButton alloc] init];
     temp.backgroundColor = [UIColor blueColor];
     temp.frame = CGRectMake(0,(self.view.frame.size.height/2),self.view.frame.size.width,1);
     [self.view addSubview:temp];
     */
    
    // Setup an index and go, go, go
    int index = 0;
    // Loop through rows
    for(int y=0; y<gridSize; y++) { // Remember to loop from the outside in!
        float newY = centerY + (y * (buttonSize + padding));
        
        // Loop through columns
        for(int x=0; x<gridSize; x++) {
            float newX = centerX + (x * (buttonSize + padding));

            // Create button per cell
            UIButton *defaultButton = [[UIButton alloc] init]; // Init button
            [defaultButton addTarget:self action:@selector(buttonWasPushed:) forControlEvents:UIControlEventTouchUpInside]; // Add action
            defaultButton.backgroundColor = [UIColor blueColor]; // Set background color
            [defaultButton setTitle:gridValues[x][y] forState:UIControlStateNormal]; // Set default text (title)
            defaultButton.tag = index; // Set unique tag id
            defaultButton.frame = CGRectMake(newX,newY,buttonSize,buttonSize); // Set frame
            [self.view addSubview:defaultButton]; // Add to view
            
            // Log and reset
            printf("Added button %d to view.\n", index);
            defaultButton = nil;
            index++;
        }
    }

    // Fun debug statement:
    // po [_view recursiveDescription]
}



/*
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/



/*====================================================================*/
    #pragma mark - ACTIONS
/*====================================================================*/

-(IBAction)buttonWasPushed:(id)sender {
    // Copy sender into button variable (to please XCode's sassiness)
    UIButton *button = [[UIButton alloc] init];
    button = sender;
    
    // Log the action
    printf("Button %d was pushed.\n", button.tag);
    
    [self setCurrentPlayerCharacter];
    
    // Check to see if anyone's already moved here
    NSString *currentCharacter = button.titleLabel.text;
    if(gameOver) {
        printf("The game's over. Start another one!\n");
    }
    else {
        if([currentCharacter length] == 0) {
            // Update cell in gridValues
            // Do a bit of a roundabout to get the x and y values for cell position...
            NSArray *cellPos = [self getCellPos:button.tag];
            int cellX = [cellPos[0] intValue];
            int cellY = [cellPos[1] intValue];
            // Update and log...
            gridValues[cellX][cellY] = playerCharacter;
            NSLog(@"Cell values in gridValues: %@",gridValues);
            
            // Update UILabel text value to current player's symbol
            [sender setTitle:playerCharacter forState:UIControlStateNormal];
            
            // If somebody won, say something!
            [self checkWin];
            if(gameOver) {
                statusLabel.text = [NSString stringWithFormat:@"%@ wins!",winner];
//                NSLog(@"%@ wins!",winner);
            }
            else {
                // Otherwise, next person's turn
                turn++;
                NSLog(@"Turn #%d",turn);
                
                if(turn > ((gridSize*gridSize)-1)) {
                    statusLabel.text = @"The game is a draw!";
                    gameOver = true;
                }
                else {
                    [self setCurrentPlayerCharacter];
                    statusLabel.text = [NSString stringWithFormat:@"%@, it's your turn", playerCharacter];
                }
            }
        }
        else {
            // Log the action
            printf("Space already taken. Try another one!\n");
        }
    }
}



-(IBAction)newGameButtonWasPushed:(id)sender {
    [self resetGame];
}


-(void)setCurrentPlayerCharacter {
    // Set current player's character
    if(turn%2==0) { playerCharacter = @"X"; }
    else { playerCharacter = @"O"; }
}

-(NSArray *)getCellPos:(int) tag {
    int xPos = tag%gridSize;
    int yPos = (tag-xPos)/gridSize;
    
    NSNumber *cellX = [NSNumber numberWithInt:xPos];
    NSNumber *cellY = [NSNumber numberWithInt:yPos];

    NSArray *cellPos = [[NSArray alloc] initWithObjects:cellX, cellY, nil];
    return cellPos;
}



// Variation of code from http://stackoverflow.com/questions/1056316/algorithm-for-determining-tic-tac-toe-game-over-java
-(void)checkWin {
    // Check rows
    for(int y=0; y<gridSize; y++) { // Remember to loop from the outside in!
        for(int x=1; x<gridSize; x++) {
            // If the space matches the one before it...
            if(![gridValues[x][y] isEqualToString:gridValues[x-1][y]]) { break; }
            if(x == gridSize-1 && [gridValues[x][y] length] > 0) {
                gameOver = true;
                winner = gridValues[x][y];
            }
        }
    }
    
    if(gameOver) { return; }
    
    // Check columns
    for(int x=0; x<gridSize; x++) {
        for(int y=1; y<gridSize; y++) {
            // If the space matches the one before it...
            if(![gridValues[x][y] isEqualToString:gridValues[x][y-1]]) { break; }
            if(y == gridSize-1 && [gridValues[x][y] length] > 0) {
                gameOver = true;
                winner = gridValues[x][y];
            }
        }
    }
    
    if(gameOver) { return; }
    
    // Check diag 1
    for(int i=1; i<gridSize; i++) {
        if(![gridValues[i][i] isEqualToString:gridValues[i-1][i-1]]) { break; }
        if(i == gridSize-1 && [gridValues[i][i] length] > 0) {
            gameOver = true;
            winner = gridValues[i][i];
        }
    }
    
    if(gameOver) { return; }
    
    // Check diag 2
    for(int i=1; i<gridSize; i++) {
        // Remember we're going backwards, so the previous space == +1!
        if(![gridValues[(gridSize-1)-i][i] isEqualToString:gridValues[(gridSize-1)-i+1][i-1]]) { break; }
        if(i == gridSize-1 && [gridValues[(gridSize-1)-i][i] length] > 0) {
            gameOver = true;
            winner = gridValues[(gridSize-1)-i][i];
        }
    }
    
    if(gameOver) { return; }
}



@end
