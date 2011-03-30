//
//  IFColorConversions.h
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

struct IFColorRGB
{
	int r;
	int g;
	int b;
};
typedef struct IFColorRGB IFColorRGB;

struct IFColorHSL
{
	int h;
	int s;
	int l;
};
typedef struct IFColorHSL IFColorHSL;

struct IFColorHSV
{
	int h;
	int s;
	int v;
};
typedef struct IFColorHSV IFColorHSV;

IFColorRGB IFColorRGBMake(int r, int g, int b);

// Conversions from RGB
IFColorHSL IFConvertRGBToHSL(IFColorRGB rgb);
IFColorHSV IFConvertRGBToHSV(IFColorRGB rgb);

// Conversions to RGB
IFColorRGB IFConvertHSLToRGB(IFColorHSL hsl);
IFColorRGB IFConvertHSVToRGB(IFColorHSV hsv);