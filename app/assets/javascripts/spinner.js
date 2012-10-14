var opts = {
  lines: 13, // The number of lines to draw
  length: 30, // The length of each line
  width: 12, // The line thickness
  radius: 40, // The radius of the inner circle
  corners: 1, // Corner roundness (0..1)
  rotate: 0, // The rotation offset
  color: '#000', // #rgb or #rrggbb
  speed: 1.4, // Rounds per second
  trail: 68, // Afterglow percentage
  shadow: true, // Whether to render a shadow
  hwaccel: true, // Whether to use hardware acceleration
  className: 'spinner', // The CSS class to assign to the spinner
  zIndex: 2e9, // The z-index (defaults to 2000000000)
  top: 'auto', // Top position relative to parent in px
  left: 'auto' // Left position relative to parent in px
};
var target = document.getElementById('spinner');
var spinner = new Spinner(opts).spin(target);
