# slots = {
#     80: 1,
#     830: 2,
#     90: 3,
#     930: 4,
#     100: 5,
#     1030: 6,
#     110: 7,
#     1130: 8,
#     120: 9,
#     1230: 10,
#     130: 11,
#     1330: 12,
#     140: 13,
#     1430: 14,
#     150: 15,
#     1530: 16,
#     160: 17,
#     1630: 18,
#     170: 19,
#     1730: 20,
#     180: 21,
#     1830: 22,
#     190: 23,
#     1930: 24,
#     200: 25,
#     2030: 26
# }



import json
courses_json = json.load(open("./json/courses.json","r"))
rooms = dict()
def room_creator(courses):
    for course in courses:
        print(course["schedules"])

room_creator(courses=courses_json)
start_sloth = 8
end_sloth = 10
start_slotm = 0
end_slotm = round(29,-1)
print((end_sloth - start_sloth) * 2 + abs(end_slotm - start_slotm)//30)
