# Multimedia

A collection of services for obtaining, managing and viewing multimedia

These apps are all grouped together in the same argo app/namespace, as they need to share resources (volumes & nfs shares).
I think it makes logical sense to group them together

Made up of
* Various *arr apps for managing movies/tv series, and managing nzbget
  * Sonarr for TV series
  * Radarr for movies
  * Prowlarr for managing indexers for the above *arr apps
* Nzbget for fetching media from usenet
* Jellyfin for hosting/streaming media (hosted externally, on nas)
* Unmaniac for managing library

## TODO
* Subtitles manager
* Lidarr & Readarr
