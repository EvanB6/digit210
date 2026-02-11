<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output method="xml"/>
    
    <xsl:variable name="xml-tree" select="doc('pokemonmoves.xml')"/>
    
    <xsl:variable name="pokemonCategories" select="$xml-tree//category => distinct-values()"/>
    <!-- text strings of the distinct categories -->
    
    <xsl:variable name="countCats" select="$pokemonCategories => count()"/>
    
    
    <!-- set up some spacing and coloring variables, like an x-spacer, y-spacer, etc.  -->
    
    <xsl:variable name="x-spacer" as="xs:integer" select="2" />
    <xsl:variable name="y-spacer" as="xs:integer" select="1" />

    <!-- *************************************************************************-->
    <!-- Stacking question: How many Pokemon moves are classified in each category? 
        
        Your SVG plot can go any direction or build a "stack" of parts in a whole in any way you wish, 
        as long as you plot it with XSLT. 
    
    *  Suggestion: If you want to base your whole plot on a percentage, the total count = 100%: 
       You could plan your plot to be based on 100 percent units * $y-spacer
    *  Portions of the stacked plot would be count-of-moves-in-each-category div total count * 100
    -->
    <!-- *************************************************************************-->

    
    <xsl:template match="/">
        <svg xmlns="http://www.w3.org/2000/svg"
            width ="1200"
            height ="1000"
            viewbox="0 0 1200 1000">
           <g transform ="translate(100, 0)">
               <!-- Figure out a transform="translate()" that makes sense based on the size of your plot... -->
        <xsl:comment>
            Call some variables in here to see what they are.
            Wait...what are the categories? <xsl:value-of select="$pokemonCategories"/>
            Count of categories in Pokemon Moves file: <xsl:value-of select="$countCats"/>
        </xsl:comment>
              <!-- Plot something that represents the total count of everything (the whole; all the Pokemon move categories). -->
               <xsl:variable name="sortedMoveCategories" as="xs:string+">
                    <xsl:for-each select="$pokemonCategories">
                    <xsl:sort select="count($xml-tree//move[category = current()])" order = "descending"></xsl:sort>
                        <xsl:value-of select="current()"/>
                   </xsl:for-each>     
                   </xsl:variable>
               
                  <xsl:variable name="cur" as="xs:string" select="current()"/>
                  <xsl:variable name="countCats" as="xs:integer" select="$xml-tree//move[category=current()] => count()"/>
                  <xsl:variable name="pos" as="xs:integer" select="position()"/>
                  <xsl:comment>
                    Category: <xsl:value-of select="$cur"/>
           Count: <xsl:value-of select="$countCats"/>
        Position: <xsl:value-of select="$pos"/>
                  </xsl:comment>
                  
          
               <xsl:variable name="colorIntensifier"
                   select="255 div count($sortedMoveCategories)"/>
               <xsl:comment>color factor is:: <xsl:value-of select="$colorIntensifier"/>
               </xsl:comment>
               
               <xsl:variable name="countAllMoves" as="xs:integer"
                   select="$xml-tree//move => count()"/>
               
               <xsl:comment>
                Categories: <xsl:value-of select="$sortedMoveCategories"/>
                Total moves: <xsl:value-of select="$countAllMoves"/>
            </xsl:comment>
               
               <!--title -->
               <text x="800" y="200"
                   style="text-anchor: middle; font-size:1.5em;">
                   Distribution of Pokémon Move Categories
               </text>
               
               <line x1="0" x2="0" stroke-width="200"
                   y1="0" y2="{$countAllMoves * $y-spacer}"
                   stroke="rgb(200,200,200)"/>
               
               <!--bars -->
               <xsl:for-each select="$sortedMoveCategories">
                   <g class="category">
                       
                       <xsl:variable name="CategoryType" select="current()"/>
                       <xsl:variable name="CategoryPosition" select="position()"/>
                       
                       <!--count moves  -->
                       <xsl:variable name="countMovesHere" as="xs:integer"
                           select="count($xml-tree//move[category = $CategoryType])"/>
                       
                       <!--som of prev category counts -->
                       <xsl:variable name="previousCounts" as="xs:integer+">
                           <xsl:choose>
                               <xsl:when test="$CategoryPosition gt 1">
                                   <xsl:for-each
                                       select="$sortedMoveCategories[position() lt $CategoryPosition]">
                                       <xsl:value-of
                                           select="count($xml-tree//move[category = current()])"/>
                                   </xsl:for-each>
                               </xsl:when>
                               <xsl:otherwise>
                                   <xsl:value-of select="0"/>
                               </xsl:otherwise>
                           </xsl:choose>
                       </xsl:variable>
               
                       <!--height-->
                       <xsl:variable name="y-stacker"
                           select="sum($previousCounts) * $y-spacer"/>
                       
                       <!--make bars-->
                       <line x1="0" x2="0"
                           y1="{$y-stacker}"
                           y2="{$y-stacker + $countMovesHere * $y-spacer}"
                           stroke-width="200"
                           stroke="rgb({$colorIntensifier * position() + 10},{$colorIntensifier * position() * 2},150)"/>
                       
                       <!--text labels-->
                       <text x="300"
                           y="{$y-stacker + ($countMovesHere * $y-spacer div 2)}"
                           style="text-anchor: middle">
                           <xsl:value-of select="$CategoryType"/>:
                           <xsl:value-of select="$countMovesHere"/> moves
                       </text>
               
               
              <!-- Then you can use <xsl:for-each> on the distinct category strings. 
                  Inside <xsl:for-each> define some variables:
                  * a variable to hold the current() value
                  * a variable to reach into the $xml-tree to find out count of moves that hold each category:
                      Here is a handy XPath for this variable: $xml-tree//move[category=current()] => count()
                 * a variable to store the position() number inside the xsl:for-each. 
                 
                 We recommend that you keep testing your variables in <xsl:comment> 
                 just to check their values before plotting in SVG elements.
    
                 Study how we created the stacked plots based on position in our example code from class:
             https://github.com/newtfire/textAnalysis-Hub/blob/main/Class-Examples/XSLT-to-SVG/TEI-to-SVG-Starter/TEI-to-SVG.xsl#L140 
              -->
               
           </g>
                   
               </xsl:for-each>
               
           </g>
        </svg>
    </xsl:template>
    
</xsl:stylesheet>