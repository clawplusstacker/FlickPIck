import urllib.request
import json


def main():
    myList = getIds()

    linkPart1 = "http://www.omdbapi.com/?i="
    linkPart2 = "&apikey=ed58eb8f"

    data = []


    for val in myList:
        full = linkPart1 + val + linkPart2

        with urllib.request.urlopen(full) as url:
            data.append(json.loads(url.read().decode()))
            print(data)

    with open('HBOfulldata.json', 'w') as json_file:
        json.dump(data, json_file, indent = 4)


def getIds():

    with open('page1.json') as f:
      data = json.load(f)

    with open('page2.json') as f:
      data2 = json.load(f)


    with open('page3.json') as f:
      data3 = json.load(f)

    with open('page4.json') as f:
      data4 = json.load(f)

    with open('page5.json') as f:
      data5 = json.load(f)

    with open('page6.json') as f:
      data6 = json.load(f)

    with open('page7.json') as f:
        data7 = json.load(f)

    with open('page8.json') as f:
        data8 = json.load(f)


    myList = []


    for movie in data['titles']:
        myList.append(movie['imdb_id'])

    for movie in data2['titles']:
        myList.append(movie['imdb_id'])

    for movie in data3['titles']:
        myList.append(movie['imdb_id'])

    for movie in data4['titles']:
        myList.append(movie['imdb_id'])

    for movie in data5['titles']:
        myList.append(movie['imdb_id'])

    for movie in data6['titles']:
        myList.append(movie['imdb_id'])

    for movie in data7['titles']:
        myList.append(movie['imdb_id'])

    for movie in data8['titles']:
        myList.append(movie['imdb_id'])

    return myList

if __name__ == "__main__":
    main()