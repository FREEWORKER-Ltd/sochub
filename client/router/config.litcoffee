Routing Configuration
=====================

Our main layout uses the sub-templates 'header', 'footer' and 'sidebar'. The header includes the top menus,
while the sidebar layout includes the side, offcanvas menu.

    Router.configure
      layoutTemplate: 'layout'
      notFoundTemplate: '404'
      loadingTemplate: 'loading'
      yieldTemplates:
        header:
          to: 'header'
        sidebar:
          to: 'sidebar'
        flash:
          to: 'flash'
        footer:
          to: 'footer'

Using a global "unload" hook to unset the flash:
    
    Router.unload ->
      Session.set('flash', null)

Feeds route is the "main" one.

    Router.map ->
      @route 'feed',
        path: '/'

      @route 'dashboard',
        path: '/dashboard'

Routes to handle login, registration, and other account managment tasks:

      @route 'login_form',
        path: '/login'

      @route 'register_form',
        path: '/register'

      @route 'reset_password',
        path: '/reset-password'

