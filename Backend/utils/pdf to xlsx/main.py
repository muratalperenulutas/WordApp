import pandas as pd
import pdfplumber

def pdf_to_xlsx(pdf_file, xlsx_file):
    with pdfplumber.open(pdf_file) as pdf:
        all_data = []
        
        for page in pdf.pages:
            words = page.extract_words()
            lastwordfinish = 0
            lasttop = 0
            word2 = ""
            j = 1

            terms = ""
            meaning1 = ""
            meaning2 = ""
            meaning3 = ""

            for word in words:
                x0 = word['x0']  
                x1 = word['x1']  
                top = word['top']  
                word1 = word['text'] 
                length = len(word1)
                charLength = (x1 - x0) / length  

                if top == lasttop:
                    if (x0 - lastwordfinish) >= (charLength * 2):
                        if j == 1:
                            terms = word2.strip()
                        elif j == 2:
                            meaning1 = word2.strip()
                        elif j == 3:
                            meaning2 = word2.strip()
                        elif j == 4:
                            meaning3 = word2.strip()
                        j += 1
                        word2 = word1
                    else:
                        word2 += " " + word1  
                else:
                    if word2:
                        if j == 1:
                            terms = word2.strip()
                        elif j == 2:
                            meaning1 = word2.strip()
                        elif j == 3:
                            meaning2 = word2.strip()
                        elif j == 4:
                            meaning3 = word2.strip()
                    
                    char_data = {
                        '1': terms,
                        '2': meaning1,
                        '3': meaning2,
                        '4': meaning3
                    }
                    all_data.append(char_data) 
                    terms = ""
                    meaning1 = ""
                    meaning2 = ""
                    meaning3 = ""
                    word2 = word1 
                    j = 1  

                lastwordfinish = x1  
                lasttop = top 

            
            if word2:
                if j == 1:
                    terms = word2.strip()
                elif j == 2:
                    meaning1 = word2.strip()
                elif j == 3:
                    meaning2 = word2.strip()
                elif j == 4:
                    meaning3 = word2.strip()
                
                char_data = {
                    '1': terms,
                    '2': meaning1,
                    '3': meaning2,
                    '4': meaning3
                }
                all_data.append(char_data)

        df = pd.DataFrame(all_data)
        df.to_excel(xlsx_file, index=False)


pdf_file = 'Oxford_Lists_B2.pdf'  
xlsx_file = 'out.xlsx' 
pdf_to_xlsx(pdf_file, xlsx_file)
