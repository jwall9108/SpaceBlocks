//
//  Level2.h
//  Sprites
//
//  Created by jeremy wall on 5/24/13.
//  Copyright (c) 2013 jeremy wall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <GameKit/GameKit.h>

@interface Level2 : CCLayerColor{
	

	 CCMenuItem* menu;	

}

+(CCScene *) scene;
- (void)onPlay:(id)sender;


@end
