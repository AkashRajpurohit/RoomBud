from flask import Flask, request, jsonify
from flask_cors import CORS, cross_origin
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import google.cloud
import webbrowser
import MatchMaking

# Initialize Flask App
app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'

# Use a service account
cred = credentials.Certificate('serviceKey.json')
firebase_admin.initialize_app(cred)

db = firestore.client()
usersRef = db.collection('users')
roomsRef = db.collection('rooms')


def matchRoommates(userId, allUsers, searchCoordinates):
    group1 = []
    group2 = []
    print("23", searchCoordinates)
    for user in allUsers:
        if(user["uid"] == userId):
            if len(searchCoordinates) > 0:
                user["coordinates"] = searchCoordinates["coordinates"]
            group1.append(user)
        else:
            group2.append(user)
    formattedInput = {"group1": group1, "group2": group2}
    return MatchMaking.apply(formattedInput)


def searchRooms(userId, allRooms, searchCoordinates):
    pass
    group2 = []
    user = usersRef.document(userId).get().to_dict()
    if len(searchCoordinates) > 0:
        user["coordinates"] = searchCoordinates["coordinates"]
    group1 = [user]
    preferences = []
    for room in allRooms:
        tenant = usersRef.document(room["tenantid"].id).get().to_dict()
        preferences = tenant["preferences"]
        # searches for room & there are no current roommates
        if len(room["currentroommates"]) == 0 and len(room["currentroommates"]) <= room["capacity"]:
            group2.append(
                {"uid": room["uid"], "preferences": list(preferences), "coordinates": room["coordinates"]})
        elif len(room["currentroommates"]) <= room["capacity"] : # searches for room & there are currenct roommates
            for user in room["currentroommates"]:
                u = usersRef.document(user.id).get().to_dict()
                preferences.extend(u["preferences"])
            group2.append(
                {"uid": room["uid"], "preferences": list(set(preferences)), "coordinates": room["coordinates"]})
    print("57 ", list(set(preferences)))
    formattedInput = {"group1": group1, "group2": group2}
    return MatchMaking.apply(formattedInput)


@app.route('/getRooms/<userId>', methods=['POST'])
def getRooms(userId):
    searchCoordinates = request.json
    allRooms = [doc.to_dict() for doc in roomsRef.get()]
    matchList = searchRooms(userId, allRooms, searchCoordinates)
    finalOutput = []
    for k, v in matchList[userId].items():
        if v > 1:
            x = [r for r in allRooms if r["uid"] == k]
            if len(x) > 0:
                x[0]["tenantid"] = x[0]["tenantid"].path
                temp = []
                for currentroommate in x[0]["currentroommates"]:
                    temp.append(currentroommate.path)
                x[0]["currentroommates"] = temp
                finalOutput.append(x[0])
    print("getRooms Output: ", finalOutput)
    return jsonify(finalOutput), 200


@app.route('/getRoommates/<userId>', methods=['POST'])
def getRoommates(userId):
    searchCoordinates = request.json
    allUsers = [doc.to_dict() for doc in usersRef.get()]
    matchList = matchRoommates(userId, allUsers, searchCoordinates)
    finalOutput = []
    for k, v in matchList[userId].items():
        if v > 1:
            x = [u for u in allUsers if u["uid"] == k and u["usertype"] != "tenant"]
            if len(x) > 0:
                finalOutput.append(x[0])
    print("getRoommates Output: ", finalOutput)
    return jsonify(finalOutput), 200


@app.route('/getUsers', defaults={'userId': None}, methods=['GET', 'POST'])
@app.route('/getUsers/<userId>', methods=['GET', 'POST'])
def read(userId):
    try:
        # Check if ID was passed to URL query
        if userId:
            if request.method == 'POST':
                searchCoordinates = request.json
                allUsers = [doc.to_dict() for doc in usersRef.get()]
                return jsonify(matchRoommates(userId, allUsers, searchCoordinates)), 200
            singleUser = usersRef.document(userId).get()
            print("Single Doc Data: ", singleUser.to_dict())
            return jsonify(singleUser.to_dict()), 200
        else:
            allUsers = [doc.to_dict() for doc in usersRef.stream()]
            print('All Docs Data: ', allUsers)
            return jsonify(allUsers), 200
    except Exception as e:
        return f"An Error Occured: {e}", 500


@app.route('/addUsers')
def addDummyData():
    try:
        id = "WCz86sEOcbMyLyBHHtiS2bnOI724"
        dummyData = {
            "aadhar": "28132108097686",
            "bio": "I am a commerce student",
            "coordinates": {
                "lat": 19.9355162,
                "long": 72.8173892
            },
            "email": "abc@gmail.com",
            "gender": "male",
            "name": "ABC XYZ",
            "phone": "12345693743",
            "preferences": [
                "morning",
                "extrovert",
                "alcoholic",
                "vegetables",
                "non smoking"
            ],
            "uid": id,
            "profile": "",
            "usertype": "tenant"
        }
        print("hello")
        usersRef.document(id).set(dummyData)
        return jsonify({"success": True}), 200
    except Exception as e:
        return f"An Error Occured: {e}", 500


@app.route('/')
def start():
    return "<h1>Match-Making Machine Learning Algorithm</h1>"


if __name__ == '__main__':
    app.run()
