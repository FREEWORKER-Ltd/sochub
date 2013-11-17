Feed Publications
=================

The currently logged in user should see things that exist in his feed, regardless of source. Users should be able to publish
new items to their own feed.

    Meteor.publish("feed", -> share.Feed.find())
