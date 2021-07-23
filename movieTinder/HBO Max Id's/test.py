import json

linkPart1 = "http://www.omdbapi.com/?i="
linkPart2 = "&apikey=55e4aa"

full = linkPart1 + "tt0455760" + linkPart2

with urllib.request.urlopen(full) as url:
    data = json.loads(url.read().decode())
    print(data)