#Set Up the data objects representing the free space and winning options

freespace =
  text: "Gospel is Presented"
  selected: true
  isFreeSquare:true

possibilities = [
  [0,1,2,3,4],
  [5,6,7,8,9],
  [10,11,12,13,14],
  [15,16,17,18,19],
  [20,21,22,23,24],
  [0,5,10,15,20],
  [1,6,11,16,21],
  [2,7,12,17,22],
  [3,8,13,18,23],
  [4,9,14,19,24],
  [0,6,12,18,24],
  [20,16,12,8,4]
]

# Define the controller for the board.  Handles the game logic
window.BoardCtrl = ($scope, $http) ->
  $http.get('squares.json').success (data) ->
    squares =  fisherYates data.squares
    squares = squares.slice 0, 24
    squares.splice 12, 0, freespace
    $scope.squares = squares

    $scope.toggle = (square) ->
      square.selected = !square.selected;

    $scope.isBingo = () ->
      possibilities.some( (possibility)-> 
        isMatch = isBingoMatch(possibility,squares) 
        if isMatch then fillspots(possibility,squares)
        isMatch
      )

    board = document.getElementById "bingoboard"
    board.className = ""
    # return undefined
    undefined

# Borrowed from: https://gist.github.com/ddgromit/859699
# Randomizes the order of elements in the passed in array in place.
fisherYates = (arr) ->
    i = arr.length;
    if i == 0 then return false
 
    while --i
        j = Math.floor(Math.random() * (i+1))
        tempi = arr[i]
        tempj = arr[j]
        arr[i] = tempj
        arr[j] = tempi
    return arr

#checks to see if all the squares in a set are selected
isBingoMatch = (set,board) ->
  set.every (item) -> 
    board[item].selected or board[item].isFreeSquare

# fill the spots on the board if they're part of a bingo
fillspots = (possibility,squares) ->
  for squarevalue in possibility
    square = squares[squarevalue]
    square.bingo = true;
