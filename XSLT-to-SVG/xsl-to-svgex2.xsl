<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:variable name="x-spacer" select="200"/>
    
    <xsl:variable name="y-spacer" select="100"/>
    
    
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        <svg width="100%">
            <desc>SVG created from <xsl:apply-templates select="//title"/></desc>
            
            <!-- I'm applying transform="translate()" to anticipate that I need a plot with y values in the 500s.
                0,0 will move down the screen to 20, 500. 
            See https://www.w3schools.com/graphics/svg_transformations.asp 
            -->
            
            <rect width="100%" height="100%" fill="rgb(15,6,22)" ></rect>
            
            
            
            
            
            <g transform="translate(20 800)">
                
                <xsl:for-each select="descendant::div">
                    
                    <circle cx="{count(descendant::sp[@who='Momo']) * position()}" cy="{position() * 2}" r ="2" fill="white" stroke="black"></circle>
                    
                    
                    
                    
                </xsl:for-each>
                
                
            </g>
            
            
        </svg>  
    </xsl:template>
    
    
    
    
    
    
    
    
    
</xsl:stylesheet>