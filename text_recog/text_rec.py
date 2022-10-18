from PIL import Image
import pytesseract, re, os
from collections import OrderedDict


def find_prices_all_items(text, check_total):
    price_list = OrderedDict() # Dict price_list store (key:value) = (item_name, price)
    total = None # total amount stated in the receipt

    # For each line in the text
    for line in text.splitlines():
        # print("Line:", line)

        # If the line shows the total amount of the receipt, and there is already item(s) in the price_list
        if (re.findall(r"TOTAL|SUBTOTAL|total|subtotal|Total|Subtotal", line)) and price_list:
            try:
                total = re.findall(r"\d+\.\d{2}", line)[0]
            except:
                total = None
            break
    
        # If the line shows the amount of GST, skip
        if (re.findall(r"GST|gst", line)):
            continue

        # If the line shows a PROMOTION for the item right above it that hasn't been subtracted of the price, we subtract the promotion amount to the price of that item
        if (re.findall(r"PROMOTION|promotion", line)):
            promo = re.findall(r"\d+\.\d{2}", line)
            if len(promo) == 1:
                item_name = list(price_list.keys())[-1]
                discounted_price = float(price_list[item_name]) - float(promo[0])
                # print(float(price_list[item_name]), float(promo[0]))
                # print(discounted_price)
                discounted_price = "%.2f" % discounted_price
                price_list[item_name] = discounted_price
                # print("Discounted_price", discounted_price)
            continue
        
        # Find all float with 2 decimals
        prices = re.findall(r"\d+\.\d{2}", line)
        if len(prices) == 1:
            item_name = re.sub(r" \d+\.\d{2}", "", line)
            # print(item_name)
            price_list[item_name] = prices[0]
            
        # print()

    # Check if total amount matches the sum of items' prices
    if check_total and total:
        items_total = sum([int(price.replace('.', '')) for price in price_list.values()])
        total1 = int(total.replace('.', ''))
        if items_total != total1:
            print("Item Sum does not match Total Amount:", "Item Sum =", items_total, ',', "Total =", total1)
            return None

    return {
        'price_list': price_list,
        'total': total
    }


def predict_text(image_name):
    # Image resizing
    # img = Image.open(image_name)
    # img = img.resize((int(img.size[0]*1.5), int(img.size[1]*1.5)))

    # Read the text in the image
    text = pytesseract.image_to_string(os.path.join('FromAndroid', image_name)) # tessaract image to string

    # Since tessaract might mistake a '.' for a ',', we convert all ',' in the returned string to '.'
    text = text.replace(',', '.')
    # print(text)
    
    return find_prices_all_items(text, False)

if __name__ == '__main__':
    print(predict_text('sample15.jpg'))