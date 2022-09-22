import 'babel-polyfill';

export var Page = {
  init: function() {
    addEventListener('DOMContentLoaded', function() {
      const cells = document.getElementsByClassName('cell');
      for (const cell of cells) {
        const placeUrl = cell.getAttribute('data-place-url');
        cell.addEventListener('click', async function() {
          const response = await fetch(placeUrl);
          const responseContent = await response.json();
          document.getElementById('message').innerText = responseContent.message;
          for (const placement of responseContent.placements)
          {
            const placementCell = document.querySelector(`.cell[data-position='${placement.row},${placement.column}']`)
            placementCell.classList += placement.symbol;
          }
        });
      }
      
      const newGameButton = document.getElementById('new-game-button')
      document.getElementById('board-size').addEventListener('change', function() {
        newGameButton.disabled = !isBoardSizeValid();
      });

      newGameButton.addEventListener('click', function() {
        window.location.href = newGameButton.getAttribute('data-url')
          + `?player=${document.getElementById('player-selection').value}&board-size=${document.getElementById('board-size').value}`;
      });
    });
  }
}

function isBoardSizeValid() {
  const boardSizeElement = document.getElementById('board-size');
  var boardSize = parseInt(boardSizeElement.value)
  if (isNaN(boardSize))
    return false;
    
  var min = parseInt(boardSizeElement.getAttribute('min')), max = parseInt(boardSizeElement.getAttribute('max'));
  return (min <= boardSize && boardSize <= max);
}
