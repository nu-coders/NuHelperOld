import json
courses = open("./json/courses.json", "r", encoding="UTF-8")
courses_json = json.load(courses)

courses_output = dict()

courses_dic = dict()
courses_output_json = open("./json/courses_.json", "w", encoding="UTF-8")

for course in courses_json:
    if course["eventSubType"] in ["Lecture", "Project"]:
        # courses_output += course
        id = course["eventId"]+'-' + course["section"]
        if id not in courses_dic:
            courses_dic[id] = list()

    if course["eventSubType"] in ["Lab", "Tutorial"]:
        id = course["eventId"]+'-' + course["section"][:-1]
        if id not in courses_dic:
            courses_dic[id] = list()
        courses_dic[id].append(course)
        # courses_json.remove(course)

for course in courses_json:
    if course["eventSubType"] in ["Lecture", "Project"]:
        id = course["eventId"]+'-' + course["section"]
        lab_tut = courses_dic[id]
        if lab_tut != []:
            course["toTake"] = courses_dic[id]
            for i in courses_dic[id]:
                courses_json.remove(i)

courses_output_json.write(json.dumps(courses_json))
