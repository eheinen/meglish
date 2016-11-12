# Megli.sh

**In this first moment I'm testing the gem!**

Megli.sh is a super framework to be used with Calabash-Android

You don't need to put scroll_down or scroll_up to find an element in order to interact with it anymore. 
Just use the commands and let Megli.sh works for you.

### Installation
In https://rubygems.org/gems/meglish you find the gem or just install:
```
gem install meglish
```

### Configuration
You can set the following values to manage globally the commands:

```
ENV[:clear_text] = true
ENV[:scroll_to_element] = true
ENV[:include_all] = true
ENV[:timeout] = 30
ENV[:confirm_alert] = true
ENV[:meglish_log] = true
```

**clear_text:** When you use the command **touch_and_keyboard_text_element**, if clear_text is **true** then Meglish will clear the field before to enter the text.  
**scroll_to_element:** This value is responsible for navigate to the element wherever it is. Use it carefully!  
**include_all:** Used to merge the query if the word "all" in order to find the element wherever it is.  
**timeout:** Time to wait an element appear.  
**confirm_alert:** If a command is waiting for an alert, it will confirm it. For instance: Command **set_date_element**.  
**meglish_log:** Write in console the query in execution.  

You can use the values above in all commands. For instance:
```
query = "MDButton id:'md_buttonDefaultPositive'"
touch_element(query) => It will use the default values
touch_element(query, include_all: false)
touch_element(query, { include_all: false, scroll_to_element: false })

options = { include_all: false, scroll_to_element: false }
touch_element(query, options)
```

