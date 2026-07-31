.pragma library


const MISC_GROUP = "cat-miscgroup"

var groupCaptionMap = {
    "cat-kitten": "Kitten caption",
    "cat-orange": "Orange caption",
    "cat-sleeping": "Sleeping caption"
}

var pictureCaptionMap = {
    "cat-loafing": "Loafing caption",
    "cat-meowing": "Meow caption",
    "cat-random": "Random caption",
    "cat-standing": "Standing caption",

    "cat-miscgroup_1": "Misc group caption 1",
    "cat-miscgroup_2": "Misc group caption 2",
    "cat-miscgroup_3": "Misc group caption 3"
}

function pickPretty(photosModel) {

    let list = buildPhotoList(photosModel)
    let groups = buildGroups(list)

    let groupNames = Object.keys(groups)


    shuffle(groupNames)

    let result = []
    let usedGroups = new Set()

    while (result.length < 5) {

        // pick random group
        let g = groupNames[Math.floor(Math.random() * groupNames.length)]

        // if it's NOT misc and already used → skip
        if (g !== MISC_GROUP && usedGroups.has(g))
            continue

        let photos = groups[g]

        let randomPhoto = photos[Math.floor(Math.random() * photos.length)]

        result.push(randomPhoto)

        // mark group as used (only for non-misc)
        if (g !== MISC_GROUP)
            usedGroups.add(g)
    }

    console.log(JSON.stringify(result, null, 2))
    return result

}


function buildPhotoList(model) {

    let list = []

    for (let i = 0; i < model.count; i++) {

        let base = model.get(i, "fileBaseName")
        let url  = model.get(i, "fileUrl")
        let groupName = getGroupName(base)

        list.push({
                      baseName: base,
                      url: url,
                      group: groupName,
                      caption: pictureCaptionMap[base] ?? groupCaptionMap[groupName]
                      // caption: groupName === MISC_GROUP ? pictureCaptionMap[base] : groupCaptionMap[groupName]
                  })
    }

    return list
}

function getGroupName(baseName) {

    let idx = baseName.indexOf("_")

    if (idx === -1)
        return baseName

    return baseName.substring(0, idx)
}

function buildGroups(photoList) {

    let groups = {}

    for (let p of photoList) {

        if (!groups[p.group])
            groups[p.group] = []

        groups[p.group].push(p)
    }

    return groups
}


function shuffle(arr) {

    for (let i = arr.length - 1; i > 0; i--) {

        let j = Math.floor(Math.random() * (i + 1))
        let temp = arr[i]
        arr[i] = arr[j]
        arr[j] = temp
    }
}
