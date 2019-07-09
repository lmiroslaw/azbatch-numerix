# Version 8.7.2019

import sys
import time
import json

from nxpy import nxpropy as nx
import pprint as pp 

import os.path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname( __file__ ), '/usr/lib64/python3.6
/site-packages/'')))

# Pricing request file name
nx_pricing_file = "nx_request.xml"

if len(sys.argv) >= 1:
    nx_pricing_file = sys.argv[1]

print(sys.argv[0], sys.argv[1])

# Load the application Objects

start_time = time.time()

app = nx.Application()
warn = nx.ApplicationWarning()
data = nx.ApplicationData()

app.read_xml(nx_pricing_file, warn)
app.view("EQ.NXKERNELCALL", "PV",data,warn)
pv = (data.data("PV")[0])

end_time = time.time()

print(json.dumps({
    'Execution Time'     : time.strftime("%m/%d/%Y, %H:%M:%S", time.localtime()),
    'Exectuion Type'     : 'manual script',
    'Calculation Type'   : 'EQ - PV',	
    'Calculation Value'  : pv,
    'Execution Duration' : end_time  - start_time,
	'Input File' : nx_pricing_file
}))

