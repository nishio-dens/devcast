jQuery( document ).on( 'turbolinks:load', function() {
  var $ = jQuery;

  /**
   * Improve anchors click behaviour:
   * - Scroll to hash
   * - Prevent useless refresh
   */
  $('a').on( 'click', function( event ) {

    var $this = $(this);

    var current_url_relative = window.location.href.replace(window.location.origin,'').split('#')[0];
    var href = $(this).attr('href');
    var href_url_relative = href.replace(window.location.origin,'').split('#')[0];
    var is_same_page = current_url_relative === href_url_relative;

    if (href.startsWith("#") || is_same_page) {
      event.preventDefault();

      /**
       * Position to scroll to.
       *
       * - No-hash: 0
       * - Hash: the position of the referenced element (uses HTML id attribute)
       *
       * @type Integer
       */
      var to = ($this.is('[href*=#]')) ? $(this.hash).offset().top : 0;

      /**
       * Scroll.
       */
      $('html,body').animate({ scrollTop : to });

      /**
       * Update address bar and history
       */
      if ( history.pushState ) {
        history.pushState( null, null, $this.attr('href') );
      }
    }
  } );
} );
