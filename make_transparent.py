from PIL import Image
import os

def remove_white_background(input_path):
    try:
        img = Image.open(input_path)
        img = img.convert("RGBA")
        datas = img.getdata()

        newData = []
        for item in datas:
            # Change all white (also shades of whites)
            # to transparent
            if item[0] > 240 and item[1] > 240 and item[2] > 240:
                newData.append((255, 255, 255, 0))
            else:
                newData.append(item)

        img.putdata(newData)
        img.save(input_path, "PNG")
        print(f"Successfully processed {input_path}")
    except Exception as e:
        print(f"Error processing image: {e}")

if __name__ == "__main__":
    path = r"C:\Users\migue\Desktop\project2\assets\branding\no_ads.png"
    if os.path.exists(path):
        remove_white_background(path)
    else:
        print(f"File not found: {path}")
