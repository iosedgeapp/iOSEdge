#!/bin/sh

#  Script.sh
#  BepBop
#
#  Created by Hiedi Utley on 9/14/13.
#  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.

IOS_PLATFORM_DEVICE="iOS"
IOS_PLATFORM_SIMULATOR="iOS Simulator"

IOS_50="5.0"
IOS_51="5.1"
IOS_60="6.0"
IOS_61="6.1"
IOS_70="7.0"

IPAD="IPad"
IPAD_RETINA="iPad Retina";
IPHONE="iPhone";
IPHONE_RETINA="iPhone Retina (3.5-inch)";
IPHONE_RETINA_4INCH="iPhone Retina (4-inch)";
IPHONE_RETINA_4INCH_64BIT="iPhone Retina (4-inch 64-bit)";

xcodebuild -workspace 'iOSEdge.xcworkspace' -scheme 'BepBop' \
-destination "platform=${IOS_PLATFORM_SIMULATOR},name=${IPHONE},OS=${IOS_61}" \
-destination "platform=${IOS_PLATFORM_SIMULATOR},name=${IPHONE_RETINA},OS=${IOS_61}" \
-destination "platform=${IOS_PLATFORM_SIMULATOR},name=${IPHONE_RETINA_4INCH},OS=${IOS_61}" \
-configuration Release test


