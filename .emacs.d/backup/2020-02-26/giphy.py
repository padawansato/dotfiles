saveas = [1250,834]
img = [1578,992]
del = [1608,959]


def main(){
    pyautogui.click(x=x, y=y, clicks=1, button="left")
    pyautogui.click(x=img[0], y=img[1], clicks=1, button="left")
    pyautogui.click(x=img[0], y=img[1], clicks=1, button="left")
    pyautogui.click(x=img[0], y=img[1], clicks=1, button="left")
    pyautogui.click(x=saveas[0], y=saveas[1], clicks=1, button="left")
    pyautogui.typewrite(['enter'], interval=1)
    pyautogui.typewrite(['enter'], interval=1)
}

if __name__ == ‘__main__’:
	main()
