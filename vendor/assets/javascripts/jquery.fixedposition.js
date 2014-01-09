/** Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php

    Copyright (c) 2010 Chris Iona <chris.iona@gmail.com>
   
    Permission is hereby granted, free of charge, to any person
    obtaining a copy of this software and associated documentation
    files (the "Software"), to deal in the Software without
    restriction, including without limitation the rights to use,
    copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following
    conditions:
   
    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.
   
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
    OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    OTHER DEALINGS IN THE SOFTWARE.

    Version:  1.0.0
    Project:  http://chrisiona.com/fixedposition
              https://code.google.com/p/fixedposition
    
    Tested On:
    	+ Internet Explorer 6.0.29 / WinXP
    	+ Internet Explorer 7.0.57 / WinXP
    	+ Internet Explorer 8.0.71 / Win7
    	+ Firefox 2.0.0.20 / WinXP
    	+ Google Chrome 3.0.195.38 / WinXP
    	+ Firefox 3.5.6 / OSX 10.5.8
    	+ Safari 4.0.4 / OSX 10.5.8
    	
    Available Plugin Options:
		fixedTo: 		"top", "bottom"
		debug: 			true, false
		effect: 		false, "fadeIn", "slideDown"
		effectSpeed: 		Number
		
    Example Usage:    
	$(document).ready(function(){ 
		$(".fixedbar").fixedPosition({
			debug: true,
			fixedTo: "bottom", 
			effect: "slideDown", 
			effectSpeed: 200
		});
	});
 */
 
(function($){
    $.fn.fixedPosition = function(options) {
        // Set some defaults
        var defaults = {
            fixedTo: "bottom",
            debug: false,
            effect: false,
            effectSpeed: 1000
        };
        // Let's cache some objects
        var _body = $("body");
        // Merge user options with the defaults
        var options = $.extend(defaults, options);
        // Test if the browser supports position:fixed
        var supportsPositionFixed = function() {
           _body.append( '<style>span#supportsPositionFixed{position:fixed;width:1px;height:1px;top:25px;}</style>');
           _body.append( '<span id="supportsPositionFixed"></span>' );
           var offset = $("#supportsPositionFixed").offset();
           $("#supportsPositionFixed").remove();
           return Boolean(offset.top === 25);
        };
        // The magic happens here
        return this.each( function() {
            // Cache the object
            var fb = $(this);
            // Let's see if this browser supports position:fixed
            var supported = supportsPositionFixed();
		// Show Debug if true
           	if(defaults.debug){var _doctype;try{_doctype=document.doctype.publicId;}catch(e){try{_doctype=document.getElementsByTagName("!")[0].nodeValue.replace(/^[^\"]*\"([^\"]+)\".*/,"$1");}catch(e){}}var _debugdata="<ul><h2>Debug Data</h2>";_debugdata+="<li>DOC TYPE: "+_doctype+"</li>";_debugdata+="<li>Supports <u>position: fixed</u>: <strong>"+supported+"</strong></li>";for(var i in $.browser){_debugdata += "<li>"+i+": <strong>"+$.browser[i]+"</strong></li>";};for(var i in defaults){_debugdata += "<li>"+i+": <strong>"+defaults[i]+"</strong> <em>("+(typeof defaults[i])+")</em></li>";}_debugdata+="</ul>";_body.prepend( '<div class="debug">'+_debugdata+'</div>' );}
            // If the position:fixed property is not supported
            if( !supported ) {
                // Give the object and ID if one doesn't already exist
                fb.attr("id", function(v) { return($(this).attr("id").length?$(this).attr("id"):"positionFixedID"+v) } );
                // IE "Speed Fix"
                if( (_body.css("background-image")) == "none" ) {
                    _body.css("background", "url(/images/positionFixed.jpg) fixed");
                } else {
                    _body.css("background-attachment", "fixed");
                }
                // CSS Magic: Create & Append a new class
                var expr = "";
                if(defaults.fixedTo == "top") {
                		expr = '$(document).scrollTop()';
                } else {
                		expr = '$(document).scrollTop() - $("#'+fb.attr("id")+'").outerHeight() + (document.documentElement.clientHeight || document.body.clientHeight)';
                }
                _body.append( '<style>.iefixedbar { background: #99CC99; background-image: url(/images/positionFixed.jpg);background-position: fixed; position: absolute; top: expression(eval('+expr+'));width: expression(eval(document.documentElement.clientWidth || document.body.clientWidth));}</style>');
                // Add the new class to the object
                fb.addClass("iefixedbar");
                // Apply effects if set
                if(defaults.effect){
                	switch(defaults.effect) {
                		case "fadeIn":
                			fb.hide().fadeIn(defaults.effectSpeed);
                		break;
                		case "slideDown":
                			fb.hide().slideDown(defaults.effectSpeed);
                		break;
                	}
	            }
            }
        } );        
    };
})(jQuery);
