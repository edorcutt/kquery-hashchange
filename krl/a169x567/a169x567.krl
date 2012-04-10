ruleset a169x567 {
	meta {
		name "kQuery hashchange module"
		description <<
The primary purpose of this module is to provide an evented controller
for navigation within a single page interface.

Using the Module
----------------

The hashchange module has been placed in the Kynetx Public Module
Directory. To use the module add the following `use module` pragma to
the meta section of your ruleset:

    meta {
      ...
      use module a169x567
    }

Actions
-------

init()

Load the jQuery plugin that provides an interface to browser
hashchange events.

    rule page_init {
      select when pageview ".*"
			a169x567:init();
    }

setActiveNav(<selector>)

Since I have been spending a lot of time with Twitter Bootstrap lately
this action was included. This sets the active navbar.

    rule sitenav_about {
      select when web hash_change newhash "/about$"
      {
        siteNav:setActiveNav("#navAbout");
      }
    }

Note: The selector can be any valid jQuery selector.

showPanel(<selector>)

Likewise this action has been included to as a result of my work with
Twitter Bootstrap. This displays a specific section of the document,
while hiding all of the other sections.

    rule sitenav_about {
      select when web hash_change newhash "/about$"
      {
        siteNav:setActiveNav("#navAbout");
        siteNav:showPanel("#sectionAbout");
      }
    }

Note: The selector can be any valid jQuery selector.

		>>

		provides init, setHash, setActiveNav, showPanel

		author "Ed Orcutt"
		logging off
	}

	global {

	  // --------------------------------------------
		init = defaction() {
		  callingRID = meta:callingRID();
		  {
			  emit <<
/**
 * kQuery hashchange 1.0.0 (port of jQuery hashchange 1.0.0 to KRL)
 * Copyright (c) 2008 Chris Leishman (chrisleishman.com)
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 */
(function(e){e.fn.extend({hashchange:function(g){this.bind("hashchange",g)},openOnClick:function(g){if(g===undefined||g.length==0){g="#"}return this.click(function(h){if(g&&g.charAt(0)=="#"){window.setTimeout(function(){e.locationHash(g)},0)}else{window.location(g)}h.stopPropagation();return false})}});if(e.browser.msie&&document.documentMode&&document.documentMode>=8){e.extend({locationHash:function(g){if(!g){g="#"}else{if(g.charAt(0)!="#"){g="#"+g}}location.hash=g}});return}var d;var c;e.extend({locationHash:function(g){if(d===undefined){return}if(!g){g="#"}else{if(g.charAt(0)!="#"){g="#"+g}}location.hash=g;if(d==g){return}d=g;if(e.browser.msie){a(g)}e.event.trigger("hashchange")}});e(document).ready(function(){d=location.hash;if(e.browser.msie){if(d==""){d="#"}c=e("<iframe />").hide().get(0);e("body").prepend(c);a(location.hash);setInterval(f,100)}else{setInterval(b,100)}});e(window).unload(function(){c=null});function b(){var g=location.hash;if(g!=d){d=g;e.event.trigger("hashchange")}}if(e.browser.msie){e("a[href^=#]").live("click",function(){var g=e(this).attr("href");if(e(g).length==0&&e("a[name="+g.slice(1)+"]").length==0){e.locationHash(g);return false}})}function f(){var g=c.contentDocument||c.contentWindow.document;var h=g.location.hash;if(h==""){h="#"}if(h!=d){if(location.hash!=h){location.hash=h}d=h;e.event.trigger("hashchange")}}function a(h){if(h=="#"){h=""}var g=c.contentWindow.document;g.open();g.close();if(g.location.hash!=h){g.location.hash=h}}})($KOBJ);

self.document.location.hash="!/";$KOBJ(window).hashchange(function(){if(KOBJ.hashPrevious==undefined||KOBJ.hashPrevious!=self.document.location.hash){var app=KOBJ.get_application(callingRID);app.raise_event("hash_change",{newhash:self.document.location.hash});KOBJ.hashPrevious=self.document.location.hash}});
				>>;
			}
		};

	  // --------------------------------------------
		// Change the document.location.hash

		setHash = defaction(neuHash) {
		  _neuHash = neuHash
			{
			  emit <<
				  self.document.location.hash = '!#{_neuHash}';
				>>;
			}
		};

	  // --------------------------------------------
		// Show "panel" section, hide all other panels

		showPanel = defaction(panel) {
		  _panel = panel;
			{
			  emit <<
				  $K('.sectionPanel').hide();
					$K(_panel).show();
				>>;
			}
		};

	  // --------------------------------------------
		// Update Navigation Menu Active item

		setActiveNav = defaction(navid) {
		  _navid = navid;
			{
			  emit <<
				  $K('div.nav-collapse > ul.nav').find('li').removeClass('active');
          $K(_navid).addClass('active');				  
				>>;
			}
		};

	}

  // ------------------------------------------------------------------------
  // Beyond here there be dragons :)
  // ------------------------------------------------------------------------
}
