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
@synthesize gridValues;

// Global variables
NSString *playerCharacter = @"-";
int turn = 0;
int gridSize[] = {3, 3};



-(void)viewDidLoad {
    // Make sure we get everything from the super method
    [super viewDidLoad];
    
    // Setup game
    // turn = 0;
    
    [self initGridArray];
    [self setupGrid];
}



-(void)initGridArray {
    int numCols = gridSize[0];
    int numRows = gridSize[0];
//    int numCells = numCols * numRows;
    
    // Create columns
    gridValues = [NSMutableArray arrayWithCapacity:numCols];
    
    // Create rows
    for(int x=0; x<numCols; x++)
        [gridValues insertObject:[NSMutableArray arrayWithCapacity:numRows] atIndex:x];
    
    // Initialize cells
//    int index=0;
    for(int x=0; x<numCols; x++) {
        for(int y=0; y<numRows; y++) {
            [gridValues[x] insertObject:[NSString stringWithFormat:@""] atIndex:y];
//            [gridValues[x] insertObject:[NSString stringWithFormat:@"%d",index] atIndex:y];
//            index++;
        }
    }
    
    NSLog(@"Cell values in gridValues: %@",gridValues);
}



-(void)setupGrid {
    int numCols = gridSize[0];
    int numRows = gridSize[0];
    //    int numCells = numCols * numRows;
    
    // Grid parameters
    int buttonSize = self.view.frame.size.width / 5;
    int padding = 5;
    
    // Dynamic variables for grid size and position
    int totalGridSize = (buttonSize*gridSize[0])+(padding*(gridSize[0]-1));
    float centerX = (self.view.frame.size.width/2)-(totalGridSize/2);
    float centerY = (self.view.frame.size.height/2)-(totalGridSize/2);
    
    /*  // Get a crosshair on that center
     UIButton *temp = [[UIButton alloc] init];
     temp.backgroundColor = [UIColor blueColor];
     temp.frame = CGRectMake(0,(self.view.frame.size.height/2),self.view.frame.size.width,1);
     [self.view addSubview:temp];
     */
    
    // Setup an index and go, go, go
    int index = 0;
    // Loop through columns
    for(int x=0; x<numCols; x++) {
        float newX = centerX + (x * (buttonSize + padding));

        // Loop through rows
        for(int y=0; y<numRows; y++) {
            float newY = centerY + (y * (buttonSize + padding));

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
    
    [self setCurrentPlayerCharacter];
    
    // Check to see if anyone's already moved here
    NSString *currentCharacter = button.titleLabel.text;
    if([currentCharacter length] == 0) {
        // Change the UILabel text value to current player's symbol
        [sender setTitle:playerCharacter forState:UIControlStateNormal];
        
        // Log the action
        printf("Button %d was pushed.\n", button.tag);
        
        // Increment the current turn / which player's turn it is
        turn++;
    }
    else {
        // Log the action
        printf("Space already taken. Try another one!\n");
    }
}



-(void)setCurrentPlayerCharacter {
    // Set current player's character
    if(turn%2==0) { playerCharacter = @"X"; }
    else { playerCharacter = @"O"; }
}



// Variation of code from http://stackoverflow.com/questions/1056316/algorithm-for-determining-tic-tac-toe-game-over-java
/* -(void)checkWin {
    bool win = false;
    int n = gridSize[0];

    //check col
    for(int i = 0; i < n; i++){
        if(gridValues[x][i] != playerCharacter)
            break;
        if(i == n-1){
            //report win for s
            win = true;
        }
    }

    //check row
    for(int i = 0; i < n; i++){
        if(board[i][y] != playerCharacter)
            break;
        if(i == n-1){
            //report win for s
        }
    }

    //check diag
    if(x == y){
        //we're on a diagonal
        for(int i = 0; i < n; i++){
            if(board[i][i] != playerCharacter)
                break;
            if(i == n-1){
                //report win for s
            }
        }
    }

    //check anti diag (thanks rampion)
    for(int i = 0;i<n;i++){
        if(board[i][(n-1)-i] != playerCharacter)
            break;
        if(i == n-1){
            //report win for s
        }
    }
} */



@end
