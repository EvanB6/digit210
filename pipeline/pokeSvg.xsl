<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/2000/svg"
    exclude-result-prefixes="xs math"
    version="3.0">
    <!-- ebb: Here's an XSLT file designed to read TEI and output SVG.
        Notice it has an xpath-default-namespace pointing to the TEI namespace. 
        We still need the SVG namespace to control the output in the XSLT root element:
        see the xmlns="http://www.w3.org/2000/svg" 
        
        I'm setting this up to process a TEI XML file from the Dandandan project last fall.
        This file is showing Season 1 Episode 1 of the Dandandan anime series. 
        
        Every <div> element is a scene location. You could plot something based on counts 
        of who or what is happening in the div elements: do some document analysis and see what
        makes sense! 
    -->
    <xsl:variable name="x-spacer" as="xs:integer" select="200"/>
    
    <xsl:variable name="y-spacer" as="xs:integer" select="10"/>
    
    <xsl:output method="xml" indent="yes"/>
    
    
    <xsl:template match="/">
        <svg width="100%">
            
            <desc>SVG created from <xsl:apply-templates select="//title"/></desc>
            
            
            
            <rect width="100%" height="100%" fill="rgb(40,1,55)" stroke="black"></rect>
            
            
            <!-- I'm applying transform="translate()" to anticipate that I need a plot with y values in the 500s.
                0,0 will move down the screen to 20, 500. 
            See https://www.w3schools.com/graphics/svg_transformations.asp 
            -->
            
            
            
            <g transform="translate(0 0)">
                
                <!-- We can explore and output, using XSLT, which locations are in each structural <div> of this episode! -->
                
                <!-- searched up how to do rng, not sure how to the circles keep falling like snow. represents how many times momo talks in the text-->
                <xsl:for-each select="//move">
                    <xsl:variable name="rng" select="random-number-generator(position())"/>
                    <xsl:variable name="x" select="position() * 30 + ($rng?number * 30)"/>
                    <xsl:variable name="y" select="$rng?next()?number * 800"/>
                    
                    <circle cx="{$x}" cy="{$y}" r="6" fill="white" stroke="black"></circle>
                    
                    
                    
                    
                </xsl:for-each>

            </g>
            
            
            
            
            
        </svg>  
    </xsl:template>
    
</xsl:stylesheet>