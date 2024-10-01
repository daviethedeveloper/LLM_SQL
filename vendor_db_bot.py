import json
import openai
import os
import sqlite3
from time import time

print("Running vendor_db_bot.py!")

fdir = os.path.dirname(__file__)
def getPath(fname):
    return os.path.join(fdir, fname)

# SQLITE
sqliteDbPath = getPath("vendor.db")  
setupSqlPath = getPath("CreateTable.sql") 
setupSqlDataPath = getPath("InsertTable.sql") 


if os.path.exists(sqliteDbPath):
    os.remove(sqliteDbPath) 


sqliteCon = sqlite3.connect(sqliteDbPath)
sqliteCursor = sqliteCon.cursor()


with (
        open(setupSqlPath) as setupSqlFile,
        open(setupSqlDataPath) as setupSqlDataFile
    ):
    setupSqlScript = setupSqlFile.read()
    setupSQlDataScript = setupSqlDataFile.read()

sqliteCursor.executescript(setupSqlScript) 
sqliteCursor.executescript(setupSQlDataScript) 



def runSql(query):
    result = sqliteCursor.execute(query).fetchall()
    return result

# OPENAI Setup
configPath = getPath("config.json")  
with open(configPath) as configFile:
    config = json.load(configFile)

openai.api_key = config["openaiKey"]  # Correct way to set the OpenAI API key
openai.organization = config["orgId"]  # Set the organization ID

def getChatGptResponse(content):
    response = openai.ChatCompletion.create(
        model="gpt-4",  # Specify the correct model
        messages=[{"role": "user", "content": content}]
    )

    result = response.choices[0].message['content'].strip()
    return result

# Define your prompt strategies here, related to your database schema
commonSqlOnlyRequest = " Give me a sqlite select statement that answers the question. Only respond with sqlite syntax."

strategies = {
    "zero_shot": setupSqlScript + commonSqlOnlyRequest,
    "single_domain_double_shot": (setupSqlScript + 
                   " Which vendors sell products priced over $20? " +
                   " \nSELECT vendorname FROM Vendors WHERE VendorID IN (SELECT VendorID FROM Products WHERE ProductPrice > 20);\n " +
                   commonSqlOnlyRequest)
}


questions = [
    "Which vendors sell products priced over $20?",
    "Which vendors have the highest rating?",
    "Which vendors are located in Guatemala City?",
    "What products are sold in Antigua Guatemala?",
    "Which customers gave a 5-star rating?",
]

def sanitizeForJustSql(value):
    gptStartSqlMarker = "```sql"
    gptEndSqlMarker = "```"
    if gptStartSqlMarker in value:
        value = value.split(gptStartSqlMarker)[1]
    if gptEndSqlMarker in value:
        value = value.split(gptEndSqlMarker)[0]
    return value

# Run each strategy and question
for strategy in strategies:
    responses = {"strategy": strategy, "prompt_prefix": strategies[strategy]}
    questionResults = []
    for question in questions:
        print(question)
        error = "None"
        try:
            sqlSyntaxResponse = getChatGptResponse(strategies[strategy] + " " + question)
            sqlSyntaxResponse = sanitizeForJustSql(sqlSyntaxResponse)
            print(sqlSyntaxResponse)
            queryRawResponse = str(runSql(sqlSyntaxResponse))
            print(queryRawResponse)
            friendlyResultsPrompt = f'I asked the question "{question}" and the response was "{queryRawResponse}". Can you give a concise, friendly response?'
            friendlyResponse = getChatGptResponse(friendlyResultsPrompt)
            print(friendlyResponse)
        except Exception as err:
            error = str(err)
            print(err)

        questionResults.append({
            "question": question, 
            "sql": sqlSyntaxResponse, 
            "queryRawResponse": queryRawResponse,
            "friendlyResponse": friendlyResponse,
            "error": error
        })

    responses["questionResults"] = questionResults

    with open(getPath(f"response_{strategy}_{time()}.json"), "w") as outFile:
        json.dump(responses, outFile, indent=2)

sqliteCursor.close()
sqliteCon.close()
print("Done!")
