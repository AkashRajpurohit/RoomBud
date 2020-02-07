import Algorithmia
from nltk.stem import SnowballStemmer

example_input = {
    "group1": [
      {
          "uid": "Vincent the Conquerer",
          "preferences": [
              "reading",
              "running",
              "chilling",
              "coding",
              "seattle",
          ],
          "coordinates": {
              "lat": 47.599088077746394,
              "long": -122.3339125374332
          }
      }
    ],
    "group2": [
      {
          "uid": "Julia the Jukebox",
          "preferences": [
              "music",
              "rock",
              "coffee",
              "guitar hero"
          ],
          "coordinates": {
              "lat": 47.62446091996251,
              "long": -122.32016064226627
          }
      },
      {
          "uid": "Chelsea the Bookworm",
          "preferences": [
              "reading",
              "writing",
              "classics",
              "coffee",
              "walking"
          ],
          "coordinates": {
              "lat": 47.62446091996251,
              "long": -122.32016064226627
      }
      },
      {
          "uid": "Ana the Artist",
          "preferences": [
              "drawing",
              "art",
              "music",
              "classical music",
              "tea",
          ],
          "coordinates": {
              "lat": 47.62446091996251,
              "long": -122.32016064226627
          }
      },
      {
          "uid": "TestResult",
          "preferences": [
              "A",
              "B"
          ],
          "coordinates": {
              "lat": 0,
              "long": 0
          }
      }
    ]
}

client = Algorithmia.client('simF9pfoGFXY1Sk3VPvE236nIIg1')

def apply(input):
    # default weights for the scoring function
    weights = {
        "preferences": 1.0,
        "coordinates": 0.005
    }
    male_scoring_list = {}
    # create a preference list for each individual using the scoring function
    for maleObject in input["group1"]:
        male_scoring_list[maleObject["uid"]] = {}
        for femalObject in input["group2"]:
            score = scoring_function(weights, maleObject, femalObject)
            male_scoring_list[maleObject["uid"]][femalObject["uid"]] = score
    return male_scoring_list

def scoring_function(weights, person1, person2):
    # returns a score that gives the similarity between 2 people
    # scoring function:
    #   +add for each interest * weight
    #   -subtract location difference * weight
    ss = SnowballStemmer("english")
    score = 0.0
    
    interest_list1 = person1["preferences"]
    interest_list2 = person2["preferences"]
    
    # compare similar preferences
    for interest1 in interest_list1:
        for interest2 in interest_list2:
            stem1 = ss.stem(interest1.lower())
            stem2 = ss.stem(interest2.lower())
            
            if stem1 == stem2:
                score += weights["preferences"]
    
    # score proximity of the paired couple if coordinates exists for each person
    if "coordinates" in person1 and "coordinates" in person2:
        coord_inputs = {
            "lat1": person1["coordinates"]["lat"],
            "lon1": person1["coordinates"]["long"],
            "lat2": person2["coordinates"]["lat"],
            "lon2": person2["coordinates"]["long"],
            "type": "miles"
            }
        distance = client.algo("geo/GeoDistance").pipe(coord_inputs).result
        score -= distance * weights["coordinates"]
    
    return score