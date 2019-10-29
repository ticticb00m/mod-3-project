class AlbumsController < ApplicationController
   
    def index 
        @albums = Album.all

        render json: @albums
    end

    def show
        @album = Album.find(params[:id])

        render json: @album
    end

    def get_spotify_id (name)
        restClient = RestClient.get(("https://api.spotify.com/v1/search?q=#{name}&type=album"), 
        "Authorization" => "Bearer #{get_token}")
        response = JSON.parse(restClient)

        albumId = response["albums"]["items"].map do |album|
            album["id"]
        end.first
        albumId
    end

    def create
        
        albumID = get_spotify_id(params[:name])

        rest_client = RestClient.get("https://api.spotify.com/v1/albums/#{albumID}",
        'Authorization' => "Bearer #{get_token}")
        response = JSON.parse(rest_client)
        
        @album = Album.create({
            name: response["name"],
            songList: response["tracks"]["items"].map{|song| song["name"]},
            picture: response["images"].first["url"],
            spotifyId: response["id"]
        })
    end

    def get_token
        base_url = "https://api.spotify.com/v1"
        
        token = RestClient.post(
            ('https://accounts.spotify.com/api/token'),
            {'grant_type': 'client_credentials'},
            {'Authorization': "Basic #{spotifyKey}"}
        )
        JSON.parse(token)['access_token']
    end

    

    # secret second : to separate
    def spotifyKey
        key = "YzA0Y2Y1MGIzYWU0NDlmMjliMTg2MmFjM2Q4YjNjMWM6NWFiNTAxNDk5MjZjNDhkMTg5MjYzYjYyMzZjYTY1ZjI="
        return key
    end
end

