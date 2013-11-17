Feed
====

Handles creation and display of a user's social feed.

    Meteor.subscribe("feed")

    Template.feed.feed = ->
      share.Feed.find()
