kQuery hashchange
=================

This is a port of [jquery-hashchange](https://github.com/chrisleishman/jquery-hashchange) to the [Kynetx Rules Language](http://docs.kynetx.com/). Many thanks to Phil Windley for describing how to build a single page interface in [KBlog: Making the Back Button Work](http://www.windley.com/archives/2011/04/kblog_making_the_back_button_work.shtml).

The primary purpose of this module is to provide an evented controller for navigation within a single [page interface](http://itsnat.sourceforge.net/php/spim/spi_manifesto_en.php).

Using the Module
----------------

The hashchange module has been placed in the [Kynetx Public Module Directory](http://apps.kynetx.com/modules/a169x567). To use the module add the following `use module` pragma to the meta section of your ruleset:

    meta {
      ...
      use module a169x567
    }

Actions
-------

### init()

Load the jQuery plugin that provides an interface to browser hashchange events.

    rule page_init {
      select when pageview ".*"
			a169x567:init();
    }

### setActiveNav(<selector>)

Since I have been spending a lot of time with [Twitter Bootstrap](http://twitter.github.com/bootstrap/) lately this action was included. This sets the active navbar.

    rule sitenav_about {
      select when web hash_change newhash "/about$"
      {
        siteNav:setActiveNav("#navAbout");
      }
    }

Note: The selector can be any valid [jQuery selector](http://api.jquery.com/category/selectors/).

### showPanel(<selector>)

Likewise this action has been included to as a result of my work with Twitter Bootstrap. This displays a specific section of the document, while hiding all of the other sections.

    rule sitenav_about {
      select when web hash_change newhash "/about$"
      {
        siteNav:setActiveNav("#navAbout");
        siteNav:showPanel("#sectionAbout");
      }
    }

Note: The selector can be any valid [jQuery selector](http://api.jquery.com/category/selectors/).
