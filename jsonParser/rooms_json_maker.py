import json
courses_json = json.load(open(r"./json/courses.json", "r+"))
rooms_json = open(r"./json/rooms.json", "w+")

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
    '2030': 25
}

floors = {
    "BUB1": "Basement floor of Tarek Khalil Building - BUB1",
    "GUB1": "Ground floor of Tarek Khalil Building - GUB1",
    "FUB1": "First floor of Tarek Khalil Building - FUB1",
    "F1": "First floor of Tarek Khalil Building - F1",
    "SUB1": "Second floor of Tarek Khalil Building - SUB1",
    "RUB1": "Roof floor of Tarek Khalil Building - SUB1", # to be checked
    "BUB2": "Basement floor of Second -Main- Building - BUB2",
    "GUB2": "Ground floor of Second -Main- Building - GUB2",
    "FUB2": "First floor of Second -Main- Building - FUB2",
    "F": "First floor of Second -Main- Building - FUB2",
    "SUB2": "Second floor of Second -Main- Building - SUB2",
    "": "N/A"
}

e_v = {
    1: '8:30 AM',
    2: '9:00 AM',
    3: '9:30 AM',
    4: '10:00 AM',
    5: '10:30 AM',
    6: '11:00 AM',
    7: '11:30 AM',
    8: '12:00 PM',
    9: '12:30 PM',
    10: '13:00 PM',
    11: '13:30 PM',
    12: '14:00 PM',
    13: '14:30 PM',
    14: '15:00 PM',
    15: '15:30 PM',
    16: '16:00 PM',
    17: '16:30 PM',
    18: '17:00 PM',
    19: '17:30 PM',
    20: '18:00 PM',
    21: '18:30 PM',
    22: '19:00 PM',
    23: '19:30 PM',
    24: '20:00 PM',
    0: '20:30 PM'
}

def room_creator(courses):
    template_json = json.load(open(r"./template.json", "r"))
    template = template_json["test"]
    template_json.pop("test")
    for course in courses:
        for schedule in course["schedules"]:
            room = schedule["roomId"]
            if room not in ["Online", ""]:
                if room not in template_json:
                    template_json[room] = template.copy()
                    template_json[room]["building"] = schedule["bldgName"][-1]
                    template_json[room]["floor"] = floors[schedule["floorId"]]
    return template_json


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


def slots_filler(input_json):
    for course in courses_json:
        for schedule in course["schedules"]:
            room = schedule["roomId"]
            if room not in ["Online", ""]:
                day = schedule['scheduledDays'][0]
                start_slot = calculate_slots(schedule['scheduledStartTime'])
                end_slot = calculate_slots(schedule['scheduledEndTime'])
                for slot in range(start_slot, end_slot):
                    input_json[room][f"{day}"][f"{slot}"]['status'] = False
                    input_json[room][f"{day}"][f"{slot}"]['course'] = course["eventId"]
                    input_json[room][f"{day}"][f"{slot}"]['type'] = course["eventSubType"]
                    input_json[room][f"{day}"][f"{slot}"]['section'] = course["section"]

    return input_json


def empty_vacant(input_json):
    days = ["0", "1", "2", "3", "4", "6"]
    slots = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12",
             "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
    slots_len = len(slots)
    for room in input_json:
        for day in days:
            for slot in range(slots_len):
                status = input_json[room][day][slots[slot]]["status"]
                temp_status = status
                for i in range(slot, slots_len):
                    if status != temp_status:
                        state = "occupied"
                        if status == True:
                            state = "vacant"
                        input_json[room][day][slots[slot]]["E/V"] = f"The room is {state} until "+ e_v[i]
                        break
                    elif status == False:
                        input_json[room][day][slots[slot]]["E/V"] = "The room is occupied until the of today :("
                    elif status == True:
                        input_json[room][day][slots[slot]]["E/V"] = "The room is vacant until the end of today :)"

                    temp_status = input_json[room][day][slots[i]]["status"]
    return input_json

rooms_json.write(json.dumps(room_creator(courses_json)))
rooms_json.close()

rooms_json = open(r"./json/rooms.json", "r+")
rooms = json.load(rooms_json)

rooms_json = open(r"./json/rooms.json", "w")
sf = slots_filler(rooms)
rooms_json.write(json.dumps(empty_vacant(sf)))

print("done")
