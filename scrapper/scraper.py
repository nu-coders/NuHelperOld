import time as execution_time

import openpyxl
from bs4 import BeautifulSoup

from functions import *

start_time = execution_time.time()
output_file = "Book.xlsx"
work_book = openpyxl.load_workbook(output_file)
work_sheet = work_book.active
initial(work_sheet)

courses_website = open("coursesDump.html")
website_content = courses_website.read()
soup = BeautifulSoup(website_content, "lxml")

_courses = soup.find_all("h4", {"class": 'jss426 jss413 jss768 jss761 jss434 jss419 jss455'})
_times = soup.find_all("div", {"class": 'jss1086'})
_metadata = soup.find_all("div", {"class": 'jss569 grid-container jss570 jss523 jss592 jss545 jss590 jss543'})
_sections_temp = soup.find_all("span", {"class": 'jss426 jss413 jss768 jss761 jss429 jss425 jss455'})
_sections = list(filter(lambda x: "Section" in x.text, _sections_temp))

counter = 2
to_take = {}

for i in range(len(_courses)):
    if ("No schedule" not in _times[i].text) and ("This class has multiple meeting times" not in _times[i].text):
        course_list = course_formatter(_courses[i].text)
        section_list = section_formatter(_sections[i].text)
        metadata_list = metadata_formatter(_metadata[i].get_text(separator="|"))
        time_list = time_formatter(_times[i].get_text(separator="|"))

        if course_list[0] not in to_take:
            to_take[course_list[0]] = set()

        to_take[course_list[0]].add(section_list[1])
        str_counter = str(counter)

        work_sheet["A" + str_counter].value = course_list[0]        # Code
        work_sheet["B" + str_counter].value = course_list[1]        # Course name
        work_sheet["C" + str_counter].value = section_list[0][-1]   # Section
        work_sheet["D" + str_counter].value = section_list[1]       # Subtype
        work_sheet["E" + str_counter].value = section_list[2]       # Subsection
        work_sheet["F" + str_counter].value = metadata_list[0]      # Instructor
        work_sheet["G" + str_counter].value = metadata_list[1]      # Credit
        work_sheet["H" + str_counter].value = time_list[4]          # Day
        work_sheet["I" + str_counter].value = time_list[7]          # Room
        work_sheet["J" + str_counter].value = time_list[6]          # Floor
        work_sheet["K" + str_counter].value = time_list[5]          # Building
        work_sheet["L" + str_counter].value = time_list[0]          # StartingTime
        work_sheet["M" + str_counter].value = time_list[1]          # EndingTime
        work_sheet["N" + str_counter].value = time_list[2]          # StartingSlot
        work_sheet["O" + str_counter].value = time_list[3]          # RegStudents
        work_sheet["P" + str_counter].value = metadata_list[2]      # EndingSlot
        work_sheet["Q" + str_counter].value = 'n/a'                 # EmptySeats

        counter += 1

for i in range(2,counter):
    code = work_sheet["A" + str(i)].value
    work_sheet["R" + str(i)].value = len(to_take[code])             # ToTake

work_book.save(output_file)

print(f"Execution Time = {execution_time.time() - start_time}s")
