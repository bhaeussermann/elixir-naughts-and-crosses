export var Page = {
  init: function() {
    $(function() {
      $(".cell").on("click", function() {
        $.ajax({
          url: $(this).data("placeUrl"),
          success: function(response) {
              $("#message").text(response.message);
              response.placements.forEach(function(placement) {
                $(".cell[data-position='" + placement.row + "," + placement.column + "']").addClass(placement.symbol)
              });
            }
          });
      });
      
      $("#board-size").on("change", function () {
        if (isBoardSizeValid())
          $("#new-game-button").removeAttr("disabled");
        else
          $("#new-game-button").attr("disabled", "disabled");
      });
  
      $("#new-game-button").on("click", function() {
        window.location.href = $(this).data("url") 
          + "?player=" + $("#player-selection").val() + "&board-size=" + $("#board-size").val();
      });
    });
  }
}

function isBoardSizeValid() {
  var boardSize = parseInt($("#board-size").val())
  if (isNaN(boardSize))
    return false;
    
  var min = parseInt($("#board-size").attr("min")), max = parseInt($("#board-size").attr("max"));
  return (min <= boardSize && boardSize <= max);
}
