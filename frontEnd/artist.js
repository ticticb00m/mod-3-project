let body = document.body
const artistCards = document.querySelector("#artistCards")
const artistButton = document.querySelector("#artistButton")
const artistName = document.querySelector("#artist")

function retrieveArtists (){
    fetch(`http://localhost:3000/artists`)
        .then(response => response.json())
        .then(createArtistCards)
}

function createArtistCards(artists){
    artists.forEach(artist => {
        let mainBox = document.createElement("div")
        let nameBox = document.createElement("div")
        let followerBox = document.createElement("div")
        let popularityBox = document.createElement("div")
        let backgroundBox = document.createElement("img")

        nameBox.innerText = artist["name"]
        followerBox.textContent = `Followers : ${artist["followers"]}`
        popularityBox.textContent = `Popularity : ${artist["popularity"]}/100`
        backgroundBox.src = artist["picture"]

        mainBox.append(backgroundBox,nameBox,followerBox,popularityBox)
        artistCards.appendChild(mainBox)

        mainBox.id = "card"
        nameBox.id = "title"
        followerBox.id = "cardInfo"
        popularityBox.id = "cardInfo"
        backgroundBox.id = "cardBackground"
        
        
    });
    body.appendChild(artistCards)
}
    artistButton.addEventListener("click", (event) =>{
        event.preventDefault()
       
        fetch("http://localhost:3000/artists", {
            method: "POST",
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({name: artistName.value})
        })
    })
    
retrieveArtists()