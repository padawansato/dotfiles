#!/usr/bin/env python3
# -*- coding: utf-8 -*-

### Gaze Estimation API Client ################################################
__author__  = "Yoshi Kajiki <y-kajiki@ah.jp.nec.com>"
__version__ = "0.9"
__date__    = "Oct 18, 2019"

import os
import sys
import time
import math
import json
import base64
import requests
import cv2
import numpy

## Settings ###################################################################

endPoint = 'http://a8b88762ef01211e9950f0eacce6e863-2021028779.ap-northeast-1.elb.amazonaws.com'       # for JPHACKS 2019

proxies = []
#proxies = ['http':'http://proxygate2.nic.nec.co.jp:8080', 'https':'http://proxygate2.nic.nec.co.jp:8080']

displayFlag = True
#displayFlag = False

###############################################################################
# Send Request
def sendRequest(fileData):

    # Read image
    imgArray = numpy.frombuffer(fileData, numpy.uint8)
    imgGray = cv2.imdecode(imgArray, cv2.IMREAD_GRAYSCALE)
    height, width  = imgGray.shape
    imgRawArray = numpy.reshape(imgGray, (-1))
    imgRaw = imgRawArray.tobytes()

    # Set URL
    url = endPoint + "/v1/query/gaze_byRAW"

    # Set request parameter
    reqPara = {
        'width' : width,
        'height' : height,
        'raw_b64' : base64.b64encode(imgRaw).decode('utf-8')
    }

    # Send the request
    headers = {'Content-Type' : 'application/json'}
    params = {}
    data = json.dumps(reqPara).encode('utf-8')
    res = requests.post(url, params=params, data=data, headers=headers, proxies=proxies, timeout=10)

    # Get response
    if res.status_code == 200:
        return res.json()
    else:
        print('## Error! ##')
        print(res.text)
        return []

###############################################################################
# Load File
def loadFile(filePath):

    # confirm
    if not os.path.exists(filePath):
        print('Error! The file [%s] not exists' % filePath)
        return None

    # read the file
    with open(filePath, 'rb') as f:
        fileData = f.read()

    return fileData

### Main ######################################################################
if __name__ == "__main__":

    argvs = sys.argv
    argc = len(argvs)
    if argc < 2:
        print('Usage: python3 %s inImageFile' % argvs[0])
        sys.exit(1)
    filePath = argvs[1]

    fileData = loadFile(filePath)
    results = sendRequest(fileData)

    # Show result
    print(json.dumps(results, indent=4))

    if displayFlag:
        imgArray = numpy.frombuffer(fileData, numpy.uint8)
        img = cv2.imdecode(imgArray, cv2.IMREAD_COLOR)
        width = img.shape[1]
        gazeLen = width / 5
        gazeColor = (0,255,0)
        eyesColor = (255,0,0)

        for result in results:
            reye = result['reye']
            leye = result['leye']
            gaze = result['gaze']

            # Show the result
            cv2.circle(img, (int(reye[0]), int(reye[1])), 15, eyesColor, thickness=2)
            cv2.circle(img, (int(leye[0]), int(leye[1])), 15, eyesColor, thickness=2)
            center = ((reye[0]+leye[0])/2, (reye[1]+leye[1])/2)
            gazeTop = (center[0] + gazeLen * math.sin(math.radians(gaze[0])), center[1] + gazeLen * math.sin(math.radians(gaze[1])))
            cv2.arrowedLine(img, (int(center[0]), int(center[1])), (int(gazeTop[0]), int(gazeTop[1])), gazeColor, thickness=2)

        #cv2.imwrite("gaze_output.png",img)
        cv2.imshow('image', img)
        cv2.waitKey(0)
        cv2.destroyAllWindows()
