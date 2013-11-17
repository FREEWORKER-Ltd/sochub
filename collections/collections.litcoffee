Collections
===========

The feed collection contains all items that make up the currently authenticated user's feed.
Feed items may ultimately be in many formats but will include embeddable attributes to produce
a concise, consistent feed on the home page.

    share.Feed = new Meteor.Collection("feed")
