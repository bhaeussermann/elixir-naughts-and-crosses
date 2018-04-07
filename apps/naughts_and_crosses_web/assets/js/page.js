export var Page = {
  init: function() {
    $(function() {
      $(".cell").on("click", function() {
        window.location.href = $(this).data("placeUrl");
      });
  
      $("#new-game-button").on("click", function() {
        window.location.href = $(this).data("url");
      });
    });
  }
}
