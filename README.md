# Megli.sh

Megli.sh is a super framework to be used with Calabash-Android

#### Why use Megli.sh?
All commands wait for the query be visible in the screen to interact with and you don't need to put scroll_down or scroll_up to find an element anymore. Meglish navigate automatically to your element.
Just use the commands and let Megli.sh works for you.

### Installation
In https://rubygems.org/gems/meglish you find the gem or just install:
```
gem install meglish
```

### Configuration
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

### Comands

If you want just navigate to element on screen without interact with it, you need to use the command: **find_element_on_screen(_query)**

If you have a query that has more than one elements in result and you want to work with on element specifically you may use the command **build_index(_index)**. 

For instance:

```
def get_product_list(_index = '')
   "LinearLayout id:'product_list'" + build_index(_index)
end
```

When you call the method **get_product_list** without any argument or just a empty String, then the return will be:
```
**"LinearLayout id:'product_list'"**
```

But, if pass an index like: **get_product_list(1)**, then the return will be:
```
**"LinearLayout id:'product_list' index:1 "**
```
