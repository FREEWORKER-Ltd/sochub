Handler for header logout link(s):

    Template.header.events(
      'click [href="#logout"]': (e) ->
        e.preventDefault()
        Meteor.logout( (err) ->
          if (err)
            Meteor._debug(err)
          else
            Session.set('flash', "You have been logged out.")
        )
    )

Event handlers for the login form. Attempt to log in user using given email / password:
    
    Template.login_form.events(
      'submit #login-form': (e,t) ->
        e.preventDefault()
        email = trimInput(t.find('#login-email').value)
        password = t.find('#login-password').value

        Meteor.loginWithPassword(email, password, (err) ->
          if (err)
            Session.set('flash', {message: 'Failed to log in. Invalid email or password.', type: 'warning'})
          else
            Router.go('feed')
        )
        false
    )

Event handlers for registraion. Attempt to create an account from given email + password:

    Template.register_form.events(
      'submit #register-form': (e,t) ->
        e.preventDefault()
        email = trimInput(t.find('#account-email').value)
        password = t.find('#account-password').value
        confirm_password = t.find('#account-password-confirm').value

        if isValidPassword(password) and passwordsMatch(password, confirm_password)
          Accounts.createUser(
            email: email
            password: password
            (err) ->
              if(err)
                Session.set('flash', {message: 'Error creating new account. Please try again later.', type: 'danger'})
              else
                Router.go('feed')
          )
          false
    )

Event handlers for resseting passwords:
    
    if (Accounts._resetPasswordToken)
      Session.set('resetPassword', Accounts._resetPasswordToken)

    Template.reset_password.events(
      'submit #recovery-form': (e,t) ->
        e.preventDefault()

        email = trimInput(t.find('#recovery-email').value)

        if (email?)
          Session.set('loading', true)
          Accounts.forgotPassword({email: email}, (err) ->
            if (err)
              Session.set('flash', {message: 'Password Reset Error', type: 'danger'})
            else
              Session.set('flash', 'Email sent. Please check your email.')
            Session.set('loading', false)
          )
        false

      'submit #new-password': (e,t) ->
        e.preventDefault()
        pw = t.find('#new-password-password').value
        pw_confirm = t.find('#new-password-confirm-password').value

        if (pw? and passwordsMatch(pw, pw_confirm))
          Session.set('loading', true)
          Accounts.resetPassword(Session.get('resetPassword'), pw, (err) ->
            if (err)
              Session.set('flash', {message: 'Password Reset Error', type: 'danger'})
            else
              Session.set('flash', 'Password Reset Successfully')
              Router.go('feed')
            Session.set('loading', false)
          )
        false
    )

Some helpers for validating input, etc:

    trimInput = (val) ->
      val.replace(/^\s*|\s*$/g, "")

    passwordsMatch = (val, other_val) ->
      if val == other_val
        true
      else
        Session.set('flash', {message: "Password and confirm password must match", type: 'warning'})
        false

    isValidPassword = (val) ->
      if val.length >= 6
        true
      else
        Session.set('flash', {message: "Password must be longer than 6 characters", type: 'warning'})
        false
