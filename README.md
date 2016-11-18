# Megli.sh

Megli.sh is a super framework to be used with Calabash-Android

### Why use Megli.sh?
All commands wait for the query be visible in the screen to interact with and you don't need to put scroll_down or scroll_up to find an element anymore. Meglish navigate automatically to your element.
Just use the commands and let Megli.sh works for you.

## Installation
In https://rubygems.org/gems/meglish you find the gem or just install:
```
gem install meglish
```

## Configuration
You can set the following values to manage globally the commands in your env.rb file:

```
ENV['CLEAR_TEXT'] = true
ENV['SCROLL_TO_ELEMENT'] = true
ENV['INCLUDE_ALL'] = true
ENV['TIMEOUT'] = 30
ENV['CONFIRM_ALERT'] = true
ENV['MEGLISH_LOG'] = true
```

- **clear_text:** When you use the command **touch_and_keyboard_text_element**, if clear_text is **true** then Meglish will clear the field before to enter the text.  

- **scroll_to_element:** This value is responsible for navigate to the element wherever it is. Use it carefully!  

- **include_all:** Used to merge the query if the word "all" in order to find the element wherever it is.  

- **timeout:** Time to wait an element appear.  

- **confirm_alert:** If a command is waiting for an alert, it will confirm it. For instance: Command **set_date_element**.  

- **meglish_log:** Write in console the query in execution.  

You can use the values above in all commands. For instance:
```
query = "MDButton id:'md_buttonDefaultPositive'"
touch_element(_query) => It will use the default values
touch_element(_query, include_all: false)
touch_element(_query, { include_all: false, scroll_to_element: false })

options = { include_all: false, scroll_to_element: false }
touch_element(_query, _options)
```
In your env.rb file include these things:

```
require 'meglish'

World(Calabash::Android::Operations)
include Meglish
```

## Commands

Almost all methods require an argument "**query**" and an optional hash of "**options**".
In the query argument you will pass the path to the element. Example:  
```
query = "MDButton id:'md_buttonDefaultPositive'"
```
In the options argument you may pass the options described on Configuration section to control your elements. Example:  
```
touch_element(_query, include_all: false)
```

For security, all commands send a command to close the keyboard. Because sometimes the keyboard stays open after interact with an inout text field.

When a command is executed, then the following steps are made:
- Close keyboard 
- Puts log command
- Wait element loading
- Find the element in the screen
- Scroll to element

#### build_index(index)
If you have a query that has more than one elements in result and you want to work with one element specifically you may use it.
```
# The query below should bring a list of elements:
query = "RelativeLayout id='product_item_list'"

# The query below should bring a new query: "RelativeLayout id='product_item_list' index: 0"
first_element = query + build_index(0)
```
You may also use it to work with the PluoaMapper Gem: https://rubygems.org/gems/pluoa-mapper

Let's assume our query now will be: 
```
query = "AppCompatButton id:'save'"
```

Another example:

```
def get_product_list(_index = '')
   "LinearLayout id:'product_list'" + build_index(_index)
end
```

When you call the method **get_product_list** without any argument or just a empty String, then the return will be:
```
"LinearLayout id:'product_list'"
```

But, if pass an index like: **get_product_list(1)**, then the return will be:
```
"LinearLayout id:'product_list' index:1 "
```

#### clear_text_element(query, options = {})
Clear text in an input text field
```
clear_text_element(query)
```

#### element_enabled?(query, options = {})
Get element and return if the element is enabled
```
element_enabled?(query)
```

#### element_visible?(query, options = {})
Get element and return if the element is visible in the screen
```
element_visible?(query)
```

#### find_elements(query, options ={})
Get all elements present in the app
```
elements = find_elements(query)
```

If you just want to get all visible elements in the screen, the you need to use **get_elements** command.

#### find_element_on_screen(query, options = {})
Wait for element loading, find the element in the screen and navigate to it.
```
find_element_on_screen(query)
```

#### get_elements(query, options = {})
Find the element in the **visible** screen and return an array of elements. if your element is not found, the emthod will return an empty array.
```
element_array = get_elements(query)
```

#### keyboard_enter_text_element(text, options = {})
Wait for keyboard appears and fill text in the element.
```
keyboard_enter_text_element("Eduardo Heinen")
```

#### long_press_element(query, options = {})
This command execute a long press and keep it pressed until you release it with the command **long_press_release_element** or until you make another action.
```
long_press_element(query)
```

#### long_press_release_element(query, options = {})
Just use this command after you long press an element.
```
long_press_release_element(query)
```

#### long_press_and_touch_element(query, touch_element_query, options = {})
There are some apps that has been implemented buttons to appears in the long press action, this command executes long press and touch in the button.
```
# query is the element with long press action
# touch_element_query is the button that will appear after long press
long_press_and_touch_element(query, touch_element_query)
```

#### scroll_to_top
Scroll to page until reach out the top.


#### select_spinner_item_element(spinner_query, item_text, options = {})
Select a text in a spinner.
```
query = "AppCompatSpinner id:'countries'"
select_spinner_item_element(query, "BRAZIL")
```

#### set_date_element(query_input, date, options = {})
Set a date in the DatePicker element with dialog.
Date format is year/month/day - 1991/05/26.
By default, the command closes the alert after input date, you can control it using parameter.
```
set_date_element(query, "1992/05/26")
set_date_element(query, "1992/05/26", confirm_alert: false)
```

#### touch_element(query, options = {})
Touch the element.
```
touch_element(query)
touch_element(query, include_all: false)
```

#### touch_element_by_text_position(query, text, options = {})
Used when there is a link inside your app and you not able to interact with this link.
```
# The query is your text link. For instance:
# If in your app there is a text with id "observation_text" and in the middle of this text has a link, then you will pass the text query in query argument, like:

query = "CustomFontTextView id:'observation_text'" 
touch_element_by_text_position(query, "Text Link")
```

#### touch_and_keyboard_text_element(query, text, options = {})
- Touch input text field
- Clear field
- Enter text
```
touch_and_keyboard_text_element(query)
```

#### text_element(query, text, options = {})
Get element text.
```
text_element(query)
```

#### text_spinner_element(query, text, options = {})
Get element selected in the spinner.
```
text_spinner_element(query)
```


## Improving and Issues
- Comment all methods and write how to use it.
- Parameter to choose if close or not the keyboard

## License

The code licensed here under the GNU Affero General Public License, version 3 AGPL-3.0. GNU AGPL 3.0 License. Meglish has been developed by Eduardo Gomes Heinen.
