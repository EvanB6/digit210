<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0">
    
    <p:input port="source" primary="true">
        <p:inline>
            <doc>Hello World!</doc>
            <doc>Testing calabash</doc>
        </p:inline>
    </p:input>
    
    <p:output port="result"/>
    
    <p:add-attribute
        match="doc[1]"
        attribute-name="my-att" 
        attribute-value="my-value"/>
    
    <p:add-attribute
        match="doc[2]"
        attribute-name="second-attribute" 
        attribute-value="test"/>
    
</p:declare-step>