const albumBody = document.querySelector("body")
const albumButton = document.querySelector("#albumButton")
const albumName = document.querySelector("#album")

function retrieveAlbums (){
    fetch(`http://localhost:3000/albums`)
        .then(response => response.json())
        .then(createAlbumCards)
}

function createAlbumCards(albums){
    albums.forEach(album => {
        const albumCards = document.querySelector("#albumCards")
        let mainBox = document.createElement("div")
        let nameBox = document.createElement("div")
        let songNames = document.createElement("div")
        let backgroundBox = document.createElement("img")
        
        
        
        songNames.innerText = album["songList"].slice(1,-1)
        backgroundBox.src = album["picture"]
        nameBox.innerText = album["name"]

        mainBox.append(backgroundBox,nameBox,songNames)
        albumCards.appendChild(mainBox)


        mainBox.id = "card"
        nameBox.id = "title"
        songNames.id = "cardInfo"
        backgroundBox.id = "cardBackground"

    });
    albumBody.appendChild(albumCards)
}
albumButton.addEventListener("click", event => {
    event.preventDefault()

    fetch("http://localhost:3000/albums", {
        method: "POST",
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({name: albumName.value})
    })
})

retrieveAlbums()

