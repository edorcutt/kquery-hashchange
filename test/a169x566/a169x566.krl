ruleset a169x566 {
	meta {
		name "kQuery-hashchange-test"
		description <<
			Test Ruleset for kQuery hashchange module
		>>

		author "Ed Orcutt, LOBOSLLC"
		logging off

		use module a169x567 alias siteNav 
	}

	global {

	}

  // ------------------------------------------------------------------------
  rule sitenav_init {
    select when pageview ".*"
    {
		  siteNav:init();
    }
  }

  // ------------------------------------------------------------------------
  rule sitenav_home {
    select when web hash_change newhash "/$"
    {
			siteNav:setActiveNav("#navHome");
			siteNav:showPanel("#sectionHome");
    }
  }

  // ------------------------------------------------------------------------
  rule sitenav_about {
    select when web hash_change newhash "/about$"
    {
			siteNav:setActiveNav("#navAbout");
			siteNav:showPanel("#sectionAbout");
    }
  }

  // ------------------------------------------------------------------------
  rule sitenav_contact {
    select when web hash_change newhash "/contact$"
    {
			siteNav:setActiveNav("#navContact");
			siteNav:showPanel("#sectionContact");
    }
  }

  // ------------------------------------------------------------------------
  // Beyond here there be dragons :)
  // ------------------------------------------------------------------------
}
