def initial(work_sheet):
    work_sheet.delete_cols(1, 18)
    work_sheet["A1"].value = "Code"
    work_sheet["B1"].value = "Course"
    work_sheet["C1"].value = "Section"
    work_sheet["D1"].value = "SubType"
    work_sheet["E1"].value = "SubSection"
    work_sheet["F1"].value = "Instructor"
    work_sheet["G1"].value = "Credit"
    work_sheet["H1"].value = "Day"
    work_sheet["I1"].value = "Room"
    work_sheet["J1"].value = "Floor"
    work_sheet["K1"].value = "Building"
    work_sheet["L1"].value = "StartingTime"
    work_sheet["M1"].value = "EndingTime"
    work_sheet["N1"].value = "StartingSlot"
    work_sheet["O1"].value = "EndingSlot"
    work_sheet["P1"].value = "EmptySeats"
    work_sheet["Q1"].value = "RegStudents"
    work_sheet["R1"].value = "ToTake"


def time_formatter(time: str):
    temp = time.split("|")
    output = [""] * 8

    time_part = temp[0].split(" - ")
    output[0] = time_to_24format(time_part[0])    # Start time
    output[1] = time_to_24format(time_part[1])    # End time
    output[2] = int(output[0].split(":")[0]) - 7  # Start slot
    output[3] = int(output[1].split(":")[0]) - 8  # End slot
    output[4] = days[temp[1]]  # Day

    if "Online" in temp[2]:
        output[5] = "N/A"  # Building
        output[6] = "N/A"  # Floor
        output[7] = "N/A"  # Room

    elif "Nile" in temp[2]:
        part2 = temp[2].split(', ')
        output[5] = part2[1]  # Building
        output[6] = part2[2]  # Floor
        output[7] = part2[3]  # Room
    else:
        part2 = temp[2].split(', ')
        output[5] = "N/A"  # Building
        output[6] = "N/A"  # Floor
        output[7] = part2[2]  # Room
    # Start time 0 - End time 1 - Start slot 2 - End slot 3 - Day 4 - Building 5 - Floor 6 - Room 7
    return output


def course_formatter(course: str):
    # Code 0 - Course name 1
    return course.split(": ")


def section_formatter(section: str):
    temp = section.split("|")
    output = [""] * 3
    output[0] = temp[0].split(":")[1].strip()  # Section
    output[1] = subtype[temp[2].split(":")[1].strip()]  # Subtype
    output[2] = 0  # SubSection
    if len(output[0]) > 2:
        output[2] = sub_section_formatter(output[0][-1])
        output[0] = output[0][:2]
    # Section 0 - Subtype 1 - SubSection 2
    return output


def sub_section_formatter(sub_section: str):
    return ord(sub_section.lower()) - 96


def metadata_formatter(metadata: str):
    temp = metadata.split("|")
    if len(temp) == 6:
        temp.insert(0,"|")
    output = [""] * 3
    output[0] = temp[1]  # instructor
    output[1] = temp[2]  # credit
    output[2] = temp[4]  # seats
    # instructor 0 - credit 1 - seats 2
    return output


def time_to_24format(time: str):
    temp = time[:-3].split(":")
    if "PM" in time and "12" not in time:
        temp[0] = str(int(temp[0]) + 12)
        return ":".join(temp)
    return ":".join(temp)


days = {"Saturday": 0, "Sunday": 1, "Monday": 2, "Tuesday": 3, "Wednesday": 4, "Thursday": 5, "Friday": 6}

subtype = {"Lecture": 0, "Lab": 1, "Tutorial": 2, "Project": 3}
