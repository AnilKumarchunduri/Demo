#! /usr/bin/python
import requests
import json

data = {
    "username": "sakumar",
    "password": "rsys@1234"
}
json_data = json.dumps(data)
print requests.post("https://almsbx.radisys.com/jira/rest/auth/1/session",data = json_data)

