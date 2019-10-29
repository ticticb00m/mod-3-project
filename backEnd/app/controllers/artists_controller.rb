class ArtistsController < ApplicationController
    def index
        @artists = Artist.all 
        
        render json: @artists
    end

    def show 
        @artist = Artist.find(params[:id])

        render json: @artist
    end

    def get_spotify_id(name)
        restClient = RestClient.get("https://api.spotify.com/v1/search?q=#{name}&type=artist",
        'Authorization' => "Bearer #{get_token}")
        response = JSON.parse(restClient)

        artistId = response["artists"]["items"].map do |item|
            item["id"]
        end.first
        artistId
    end

    def create    
        
        artistId = get_spotify_id(params[:name])

        rest_client = RestClient.get("https://api.spotify.com/v1/artists/#{artistId}",
        'Authorization' => "Bearer #{get_token}")
        response = JSON.parse(rest_client) 
        @artist = Artist.create({
            name: response["name"], 
            followers: response["followers"]["total"],
            popularity: response["popularity"],
            picture: response["images"].first["url"],
            spotifyId: response["id"]
        })
    end

    def get_token
        base_url = "https://api.spotify.com/v1"

        token = RestClient.post(('https://accounts.spotify.com/api/token'),
            {'grant_type': 'client_credentials'},
            {'Authorization': "Basic #{spotifyKey}"})
        JSON.parse(token)['access_token']
    end

    def spotifyKey
        key = "YzA0Y2Y1MGIzYWU0NDlmMjliMTg2MmFjM2Q4YjNjMWM6NWFiNTAxNDk5MjZjNDhkMTg5MjYzYjYyMzZjYTY1ZjI="
        return key
    end
end