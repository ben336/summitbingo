freespace =
  text: "Gospel is Presented"
  selected: true

window.BoardCtrl = ($scope, $http) ->
  $http.get('squares.json').success (data) ->
    squares =  fisherYates data.squares
    squares = squares.slice 0, 24
    squares.splice 12, 0, freespace
    $scope.squares = squares
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