freespace =
  text: "Gospel is Presented"
  selected: true
  isFreeSquare:true

possibilities = []

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
        )


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
  set.every( (item) -> board[item].selected )

fillspots