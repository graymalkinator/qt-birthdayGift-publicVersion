.pragma library

var order = []
var pos = -1

// Call once when model is ready
function initialize(count)
{
    makeShuffle(count)
}

// Create new shuffled order
function makeShuffle(count)
{
    order = []

    for (var i = 0; i < count; i++)
        order.push(i)

    // Fisher-Yates shuffle
    for (var j = count - 1; j > 0; j--) {
        var k = Math.floor(Math.random() * (j + 1))

        var temp = order[j]
        order[j] = order[k]
        order[k] = temp
    }

    pos = -1
}

// Get next song index
function nextSong()
{
    if (order.length === 0)
        return -1

    pos++

    // reached end -> reshuffle again
    if (pos >= order.length) {
        makeShuffle(order.length)
        pos = 0
    }

    return order[pos]
}

// Get previous song index
function previousSong()
{
    if (order.length === 0)
        return -1

    pos--

    if (pos < 0)
        pos = 0

    return order[pos]
}

// Current song index
function currentSong()
{
    if (pos < 0 || pos >= order.length)
        return -1

    return order[pos]
}

function prettify(name)
{
    return name.replace(/_/g, " ")
}
