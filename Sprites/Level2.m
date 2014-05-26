//
//  Level2.m
//  Sprites
//
//  Created by jeremy wall on 5/24/13.
//  Copyright (c) 2013 jeremy wall. All rights reserved.
//

#import "Level2.h"
#import "IntroLayer.h"
#import "AppDelegate.h"
#import "GameOver.h"
#import "SimpleAudioEngine.h"
#import "cocos2d.h"



@implementation Level2

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Level2 *layer = [Level2 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	
    if ((self = [super initWithColor:ccc4(100,200,0,155)])) {
		[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
		
		
		CCMenuItem *menuItem1 = [CCMenuItemFont itemWithString:@"Menu" target:self selector:@selector(onPlay:)];
        menu = [CCMenu menuWithItems: menuItem1, nil];
		menu.position = ccp(500, 300);
        [self addChild:menu];
		
	
		
    }
    return self;
    
}


- (void)onPlay:(id)sender

{
	
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:1.0 scene:[IntroLayer scene] ]];
}




@end
