import openpyxl
import json

excel_file = "Oxford_Lists_C1.xlsx"
wb = openpyxl.load_workbook(excel_file)
sheet = wb.active

json_list = []
word_count=0

for row in sheet.iter_rows(min_row=2, values_only=True):
    if row[0] is not None:
        word_count+=1
        word_data = {
            "word": row[0],        
            "meaning1": row[1],    
            "meaning2": row[2],     
            "meaning3": row[3]      
        }
        json_list.append(word_data)

with open("Oxford_Lists_C1.json", "w", encoding="utf-8") as json_file:
    json.dump(json_list, json_file, ensure_ascii=False, indent=4)

print(f"{word_count} word data was converted to JSON file.")
