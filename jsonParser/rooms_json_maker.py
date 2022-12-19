

import json
courses_json = json.load(open(r"./json/courses.json", "r+"))
rooms = dict()


def room_creator(courses):
    output = open("output.json", "w")
    test_file = open(r"./template.json", "r+")
    test_json = json.load(test_file)
    test = test_json["test"]
    for course in courses:
        for schedule in course["schedules"]:
            room = schedule["roomId"]
            if room not in ["Online", ""]:
                if room not in test_json:
                    test_json[room] = test
                    test_json[room]["building"] = schedule["bldgName"][-1]
    output.write(json.dumps(test_json))


room_creator(courses=courses_json)


slots = {
    '830': 1,
    '9': 2,
    '930': 3,
    '10': 4,
    '1030': 5,
    '11': 6,
    '1130': 7,
    '12': 8,
    '1230': 9,
    '13': 10,
    '1330': 11,
    '14': 12,
    '1430': 13,
    '15': 14,
    '1530': 15,
    '16': 16,
    '1630': 17,
    '17': 18,
    '1730': 19,
    '18': 20,
    '1830': 21,
    '19': 22,
    '1930': 23,
    '20': 24,
    '2030' : 25
}

# TODO CREATE FUNCTON TO GET SLOT

def calculate_slots(slot):
    hour = slot[0]
    minute = slot[1]
    if minute == 0:
        return slots[f"{hour}"]
    elif minute <= 30:
        return slots[f"{hour}30"]
    elif minute > 30:
        return slots[f"{hour+1}"]


s = calculate_slots([9, 0, 0])
e = calculate_slots([11, 59, 0])

# TODO DO LOOP BY RANGE(START , END)
for i in range(s, e):
    print(i)


def slots_filler():
    output = json.load(open("output.json", "r"))
    output2 = open("output2.json", "w")

    for course in courses_json:
        id = course['id']
        for schedule in course["schedules"]:
            room = schedule["roomId"]
            if room not in ["Online", ""]:
                room_id = schedule['roomId']
                day = schedule['scheduledDays'][0]
                start_slot = calculate_slots(schedule['scheduledStartTime'])
                end_slot = calculate_slots(schedule['scheduledEndTime'])
                for slot in range(start_slot,end_slot):
                    output[room_id][f"{day}"][f"{slot}"]['status'] = False
                    output[room_id][f"{day}"][f"{slot}"]['id'] = id
    output2.write(json.dumps(output))

     
slots_filler()