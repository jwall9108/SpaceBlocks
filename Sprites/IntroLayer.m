//
//  IntroLayer.m
//  Sprites
//
//  Created by jeremy wall on 4/17/13.
//  Copyright jeremy wall 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "GameOver.h"
#import "Layer2.h"
#import "Level2.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "SimpleAudioEngine.h"



#pragma mark - IntroLayer


// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

typedef enum LevelType : NSUInteger {
    main,
    kRectangle,
    kOblateSpheroid
} LevelType;


// 
-(id) init
{
	if( (self=[super init])) {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		
		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCLayerColor layerWithColor:ccc4(0,0,155,155)];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];
		

		
		CCMenuItem *menuItem1 = [CCMenuItemFont itemWithString:@"Level1" target:self selector:@selector(onPlay:)];
		menuItem1.tag = (LevelType)main;
    
		CCMenuItem *menuItem2 = [CCMenuItemFont itemWithString:@"Level2" target:self selector:@selector(onPlay:)];
		menuItem2.tag = 2;
		
		CCMenuItem *menuItem3 = [CCMenuItemFont itemWithString:@"Level3" target:self selector:@selector(onPlay:)];
		menuItem3.tag = 3;
		
		CCMenuItem *menuItem4 = [CCMenuItemFont itemWithString:@"Level4" target:self selector:@selector(onPlay:)];
		menuItem4.tag = 4;
		
		CCMenuItem *menuItem5 = [CCMenuItemFont itemWithString:@"Level5" target:self selector:@selector(onPlay:)];
		menuItem5.tag = 5;
		
		CCMenuItem *menuItem6 = [CCMenuItemFont itemWithString:@"Level6" target:self selector:@selector(onPlay:)];
		menuItem6.tag = 6;
		
		CCMenu *starMenu = [CCMenu menuWithItems:menuItem1,menuItem2,menuItem3,menuItem4,menuItem5,menuItem6,nil];
		starMenu.position = ccp(200, 225);
		NSNumber* itemsPerRow = [NSNumber numberWithInt:3];
		[starMenu alignItemsInColumns:itemsPerRow, itemsPerRow, nil];
		[self addChild:starMenu];
	}
	
	return self;
}


- (void)onPlay:(CCMenuItem*)sender 
{
	switch (sender.tag){
		case (LevelType)main:
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:1.0 scene:[Layer2 scene] ]];
		break;
			
		case 2:
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[Level2 scene] ]];
		break;
			
		case 3:
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameOver scene] ]];
		break;
			
		case 4:
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[Layer2 scene] ]];
		break;
		
		case 5:
			[[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[Layer2 scene] ]];
		break;
			
		case 6:
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:1.0 scene:[Layer2 scene] ]];
		break;
		
	}
}

@end
