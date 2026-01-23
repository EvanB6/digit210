<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="location[contains(., 'AU')]">
            <sch:assert test="@long &gt; 100 and @long &gt; 0">
                The longitude for Australian locations must be greater than 100 (east of the Prime Meridian) and positive.
            </sch:assert>
            <sch:assert test="@lat &lt; 0">
                The latitude for Australian locations must be less than 0 (southern hemisphere).
            </sch:assert>
        </sch:rule>
        <sch:rule context="location[contains(., 'USA')]">
            <sch:assert test="@long &lt; 0">
                The longitude for USA locations must be negative (west of the Prime Meridian).
            </sch:assert>
            <sch:assert test="@lat &gt; 0">
                The latitude for USA locations must be positive (northern hemisphere).
            </sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>