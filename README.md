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

**Clear_text:** When you use the command **touch_and_keyboard_text_element**, if clear_text is **true** then Meglish will clear the field before to enter the text.  
**Scroll_to_element:** This value is responsible for navigate to the element wherever it is. Use it carefully!  
**Include_all:** Used to merge the query if the word "all" in order to find the element wherever it is.  
**Timeout:** Time to wait an element appear.  
**Confirm_alert:** If a command is waiting for an alert, it will confirm it. For instance: Command **set_date_element**.  
**Meglish_log:** Write in console the query in execution.  

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

#### Base
Almost all methods require an argument "**query**" and an optional hash of "**options**".
In the query argument you will pass the path to the element. Example:  
```
query = "MDButton id:'md_buttonDefaultPositive'"
```
In the options argument you may pass the options described on Configuration section to control your elements. Example:  
```
touch_element(_query, include_all: false)
touch_element(_query, { include_all: false, scroll_to_element: false })
```

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


#### find_element_on_screen(query, options = {})
Find the element in screen and navigate to it without interact with
```
find_element_on_screen(query)
```

#### get_elements(query, options = {})
Find the element in the **visible** screen and return an array of elements. if your element is not found, the emthod will return an empty array.
```
element_array = get_elements(query)
```


## Improving
Comment all methods and write how to use it.

## License

The code licensed here under the GNU Affero General Public License, version 3 AGPL-3.0. GNU AGPL 3.0 License. Meglish has been developed by Eduardo Gomes Heinen.
