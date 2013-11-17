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
        footer:
          to: 'footer'

    Router.map ->
      @route 'feed',
        path: '/'

      @route 'dashboard',
        path: '/dashboard'
