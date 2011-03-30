//
//  IFColorConversions.c
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#include "IFColorConversions.h"
#include <math.h>

#if !defined(MIN)
#define MIN(A,B)	({ __typeof__(A) __a = (A); __typeof__(B) __b = (B); __a < __b ? __a : __b; })
#endif

#if !defined(MAX)
#define MAX(A,B)	({ __typeof__(A) __a = (A); __typeof__(B) __b = (B); __a < __b ? __b : __a; })
#endif

IFColorRGB IFColorRGBMake(int r, int g, int b)
{
	IFColorRGB color;
	color.r = r;
	color.g = g;
	color.b = b;
	
	return color;
}

// Conversions from RGB
IFColorHSL IFConvertRGBToHSL(IFColorRGB rgb)
{
	IFColorHSL hsl;
	
	float r, g, b, h, s, l;
    r = rgb.r / 256.0; 
    g = rgb.g / 256.0; 
    b = rgb.b / 256.0;
	
	float maxColor = MAX(r, MAX(g, b)); 
    float minColor = MIN(r, MIN(g, b));
	
	if(maxColor == minColor)
	{
		// If max and min are equal, then the color is a shade of grey
		h = 0.0;
		s = 0.0;
		l = r;
	}
	else
    {   
        l = (minColor + maxColor) / 2;
        
        if(l < 0.5) s = (maxColor - minColor) / (maxColor + minColor);
        else s = (maxColor - minColor) / (2.0 - maxColor - minColor);
        
        if(r == maxColor) h = (g - b) / (maxColor - minColor);
        else if(g == maxColor) h = 2.0 + (b - r) / (maxColor - minColor);
        else h = 4.0 + (r - g) / (maxColor - minColor);
        
        h /= 6;
        if(h < 0) h ++;
    }
	
	hsl.h = round(h * 255.0);
	hsl.s = round(s * 255.0);
	hsl.l = round(l * 255.0);
	
	return hsl;
}

IFColorHSV IFConvertRGBToHSV(IFColorRGB rgb)
{
	IFColorHSV hsv;
	
	float r, g, b, h, s, v;
    r = rgb.r / 256.0; 
    g = rgb.g / 256.0; 
    b = rgb.b / 256.0;
    float maxColor = MAX(r, MAX(g, b));
    float minColor = MIN(r, MIN(g, b));
    v = maxColor;
	
	if(maxColor == 0)
    {  
        s = 0;
    }
    else  
    {      
        s = (maxColor - minColor) / maxColor;
    }
	
	if(s == 0)
    {
        h = 0;
    }   
    else
    { 
        if(r == maxColor) h = (g - b) / (maxColor-minColor); 
        else if(g == maxColor) h = 2.0 + (b - r) / (maxColor - minColor);
        else h = 4.0 + (r - g) / (maxColor - minColor);       
        h /= 6.0;
        if (h < 0) h++;
    }
	
	hsv.h = round(h * 255.0);
	hsv.s = round(s * 255.0);
	hsv.v = round(v * 255.0);
	
	return hsv;
}

// Conversions to RGB
IFColorRGB IFConvertHSLToRGB(IFColorHSL hsl)
{
	IFColorRGB rgb;
	
	float r, g, b, h, s, l;
    float temp1, temp2, tempr, tempg, tempb;
    h = hsl.h / 256.0;
    s = hsl.s / 256.0;
    l = hsl.l / 256.0;
	
	// If saturation is 0, the color is a shade of gray
    if(s == 0)
	{
		r = g = b = l;
	}
	else
    {
        //Set the temporary values      
        if(l < 0.5) temp2 = l * (1 + s);
        else temp2 = (l + s) - (l * s);     
        temp1 = 2 * l - temp2;    
        tempr = h + 1.0 / 3.0;    
        if(tempr > 1) tempr--;
        tempg = h;     
        tempb = h - 1.0 / 3.0;
        if(tempb < 0) tempb++; 
        
        //Red     
        if(tempr < 1.0 / 6.0) r = temp1 + (temp2 - temp1) * 6.0 * tempr;      
        else if(tempr < 0.5) r = temp2;   
        else if(tempr < 2.0 / 3.0) r = temp1 + (temp2 - temp1) * ((2.0 / 3.0) - tempr) * 6.0;
        else r = temp1; 
        
        //Green       
        if(tempg < 1.0 / 6.0) g = temp1 + (temp2 - temp1) * 6.0 * tempg;    
        else if(tempg < 0.5) g = temp2;
        else if(tempg < 2.0 / 3.0) g = temp1 + (temp2 - temp1) * ((2.0 / 3.0) - tempg) * 6.0;
        else g = temp1; 
        
        //Blue    
        if(tempb < 1.0 / 6.0) b = temp1 + (temp2 - temp1) * 6.0 * tempb;   
        else if(tempb < 0.5) b = temp2; 
        else if(tempb < 2.0 / 3.0) b = temp1 + (temp2 - temp1) * ((2.0 / 3.0) - tempb) * 6.0;    
        else b = temp1;
    }
	
	rgb.r = round(r * 255.0);
	rgb.g = round(g * 255.0);
	rgb.b = round(b * 255.0);
	
	return rgb;
}

IFColorRGB IFConvertHSVToRGB(IFColorHSV hsv)
{
	IFColorRGB rgb;
	
	float r, g, b, h, s, v;
    h = hsv.h / 256.0; 
    s = hsv.s / 256.0; 
    v = hsv.v / 256.0;
	
	//If saturation is 0, the color is a shade of gray
    if(s == 0)
	{
		r = g = b = v;
	}
	else
    {
        float f, p, q, t;
        int i;
        h *= 6;
        i = floor(h);
        f = h - i;
        p = v * (1 - s);   
        q = v * (1 - (s * f));     
        t = v * (1 - (s * (1 - f)));
		
        switch(i)       
        {         
            case 0: r = v; g = t; b = p; break;
            case 1: r = q; g = v; b = p; break;
            case 2: r = p; g = v; b = t; break;
            case 3: r = p; g = q; b = v; break;
            case 4: r = t; g = p; b = v; break;
            case 5: r = v; g = p; b = q; break;  
        }
    }
	
	rgb.r = round(r * 255.0);
	rgb.g = round(g * 255.0);
	rgb.b = round(b * 255.0);
	
	return rgb;
}