## master ##

# 3.0.3 (2014-02-25)

* Fix a bug where kb-only portal view would not display topic names
* Add resource bundle support for cocoapods
* Fix some pedantic Xcode warnings
* Remove some unused resources
* Fix a crash related to saving external ids

# 3.0.2 (2014-01-16) ##

* Fix a crash caused by selecting a search result on the portal screen
* Fix a bug in the metrics code
* Fix a crash related to launching the sdk without a network connection

## 3.0.1 (2014-01-08) ##

* Fix an autolayout error related to textviews
* Fix a bug with overlapping text on a dialog in landscape mode
* Clean up some inconsistencies related to dismissal behavior
* Fix a bug related to forum search
* Fix a problem with deflection reporting

## 3.0.0 (2013-12-31) ##

* Revamp UI for iOS 7
* Replace idea voting mechanism with subscribing
* Redesign stylesheet API
* Update metric reporting
* New success screens
* Numerous bug fixes

## 2.0.15 (2013-12-05) ##

* Fix a bug in the initialization code related to private forums
* Fix a bug that prevented user traits from being associated with tickets

## 2.0.14 (2013-12-02) ##

* Fix potential header collision
* Fix iOS 7 crash related to custom fields
* Fix an issue where SDK launch would fail if a user identity was passed and a key pair was not passed

## 2.0.13 (2013-10-01) ##

* Add support for new UserVoice metrics
* Add the ability to control the navbar font
* Fix crash on iOS 7 when posting ideas
* Stop forcing user to return to the portal view after creating an idea or ticket
* Add the ability to customize the nav bar font

## 2.0.12 (2013-11-05) ##

* Respect specified order of articles within a topic
* Speed up initial load slightly
* Fix a potential crash when the SDK is dismissed during initial load
* Add ability to customize navigation bar title appearance
* Show action sheets from bar button item on iPad
* Update Traditional Chinese translation (thanks to bcylin)
* Add Portuguese translation (thanks to hebertialmeida)
* Add client-side forumId option
* Add a bunch of translations (thanks to rafaelbaggio)
* Remove need for client keys
* A bunch of fixes for iOS 7 (more to come)

## 2.0.11 (2013-06-03) ##

* Remove the need for -ObjC
* Use localized quotation marks

## 2.0.10 (2013-04-25) ##

* Validate required custom fields
* Fix a layout issue with long custom field values
* Fix an issue with the flash message when the forum is turned off
* Fix an issue where the navigation bar would sometimes be hidden after posting an idea
* Tweak layout of welcome screen when both buttons are hidden
* Fix an issue where incorrect idea status colors would be visible briefly when scrolling
* Fix html entity codes showing up on the idea list
* Fix html entity codes showing up in user names

## 2.0.9 ##

* Add German translation (thanks to vinzenzweber)
* Fix a layout bug affecting translated labels on the idea form
* Fix a bug where initialization would stall if sso fails

## 2.0.8 ##

* Fix a crash related to comments with null text
* Fix a crash on iOS 4.3
* Fix a bug where the number of remaining votes would not be set correctly
* Fix a compatibility issue with libraries that introspect all classes in the VM (e.g. Pony Debugger)
* Fix a bug related to showPostIdea = NO

## 2.0.7 (2013-01-25) ##

* Fix some compatibility issues with iOS 4.3
* Change 'Connecting to UserVoice' to 'Loading...' since that message is displayed before we know if the account is white-label or not
* Stop assuming that the app delegate responds to `window`

## 2.0.6 (2013-01-21) ##

* Fix a bug where kb browser would not work if forum was turned off

## 2.0.5 (2013-01-11) ##

* Fix a bug with scroll behavior on contact form
* Only show topics that have articles
* Fix a bug related to loading a single topic
* Hide UserVoice logo for white label accounts

## 2.0.4 (2012-12-26) ##

* Fix a bug introduced in 2.0.3 where dismissing a form on the iPhone resulted in a blank screen
* Fix a bug where the selected category was not displayed on the idea form

## 2.0.3 (2012-12-21) ##

* Fix a bug related to scroll insets not being set initially on form views on iPad
* Tweak forms for bluetooth keyboards
* Fix a bug related to nested modals on iPad
* Fix an infinite loop in UVTruncatingLabel
* Fix a bug related to sizing of comment text labels
* Fix a bug with the layout of the comment form
* Update Dutch translation (thanks @nvh)

## 2.0.2 (2012-12-12) ##

* Fix a bug related to textview text overflowing cell bounds on iPad
* Fix a bug causing crashes on iOS 5
* Add combined search to portal screen
* Add 'All Articles' section to knowledge base
* Fix a bug where the app would crash if UV load canceled by user

## 2.0.1 (2012-12-10) ##

* Fix a bug related to feedback-only accounts
* Add a method to directly launch the new idea screen

## 2.0.0 (2012-12-08) ##

* UI overhaul
* Add knowledgebase browser
* Add an option to specify a help topic
* Add options to turn off different parts of the UI

## 1.2.6 (2012-11-27) ##

* Fix missing submit button on new ticket form on iPad

## 1.2.5 (2012-11-07) ##

* Fix a couple of bugs related to data not refreshing after sign-in
* Add Dutch translation (thanks to nvh)
* Add support for setting external_ids on the user, for integrations
* Reload everything whenever the SDK is launched (previously we were caching data until the host app was unloaded)
* Remove warning about unconfirmed email

## 1.2.4 (2012-09-25) ##

* Add support for setting custom fields programmatically
* Add support for armv7s (iPhone 5)

## 1.2.3 (2012-08-29) ##

* Fix a bug that would cause sign-in to fail when connected to a private forum
* Remove some dead code

## 1.2.2 (2012-08-23) ##

* Fix a bug with table headers on iOS 4.3
* Fix a bug with table borders on iPad / iOS 4.3
* Show correct version number on about screen
* Simplify loading sequence
* Fix a bug with customizing the color of table view section headers
* Add Traditional Chinese translation (thanks to zetachang)
* Fix a bug where API calls were being made with malformed URLs

## 1.2.1 (2012-06-14) ##

* Track instant answers for analytics
* Add Italian translation (thanks to Piero87)

## 1.2.0 (2012-05-16) ##

* Add top articles and suggestions to welcome screen
* Make ordering of suggestions match feedback site default (Hot Ideas, New Ideas, or Top Ideas)
* Add instant answers to contact form
* Fix a bug where it appeared you could vote on declined ideas
* Add support for helpdesk-only accounts

## 1.1.1 (2012-05-07) ##

* Remove sign out button if the user is signed in programmatically
* Fix a cosmetic issue with custom fields on the iPad

## 1.1.0 (2012-04-26) ##

* Display error messages from API
* Update installation instructions
* Remove 'Leave a Rating' feature
* Remove footer from all views except welcome view
* Remove footer shadow
* Remove disclosure indicator from "Load more ideas" row
* Remove unused images
* Hide "Done" button when searching or creating suggestions
* Remove sign in message for voting
* Move add suggestion row to top of search results
* Move email/name fields below category on new suggestion view
* Back out to the welcome screen after creating a suggestion
* No longer require a user to log in to submit a ticket
* Remove subject field from contact form
* Automatically focus on text area on contact form
* Fix behavior of new suggestion link on contact form
* Fix behavior of new ticket link on new suggestion form
* Add a cancel button to loading screen for those on slow connections
* Add a method to go directly to the contact form
* Add localization support
* Add French translation (thanks to @netbe)
* Move keyboard done button to the right side on Contact Us and Suggestion forms
* Add a method to go directly to the feedback forum
* Refactor public interface
* Redesign about screen
* Add support for custom fields on contact form
* Add the ability to change the navigation bar tint color using a custom stylesheet

## 1.0.3 (2012-04-23) ##

* Fix a bug where the network connection image would be stretched in an unsightly way

## 1.0.2 (2012-02-24) ##

* Fix a bug where the number of available votes didn't get updated on user login or signup

## 1.0.1 (2012-02-21) ##

* Fix a bug with the suggestion form when there aren't any categories

## 1.0.0 (2012-02-13) ##

* First supported release
* Add (basic) iPad support
* Add landscape support
* Fix a number of bugs
* Switch to static library for distribution
* Add stylesheet support
