View helper, returns a valid flash object based on what's
stored in session can be either an object with a "message"
property (and optionally "type") or just a string.

    Template.flash.flash = ->
      flash = Session.get('flash')
      return null unless flash?
      if (typeof flash == "string")
        message = flash
        flash = {}
        flash.message = message
      flash.type ?= 'info'
      flash

Clear out the flash message the meteor way.. when the close
link is clicked, set the session 'flash' to null.

    Template.flash.events(
      'click #flash button.close': (e) ->
        Session.set('flash', null)
    )
