require 'meglish-log'

module Meglish
    MELGISH_CONDITIONS = {
        clear_text: true,
        scroll_to_element: true,
        include_all: true,
        timeout: 30,
        confirm_alert: true
    }.freeze

    def build_index(_index)
        _index.to_s.empty? ? '' : " index:#{_index} "
    end

    def clear_text_element(_query, _options = {})
        touch_element(_query.strip, _options)
        clear_text
    end

    def element_enabled?(_query, _options = {})
        get_element(_query, _options)['enabled']
    end

    def element_visible?(_query, _options = {})
        get_element(_query, _options)['visible']
    end

    def find_coordinate_element(_query, _options = {})
        find_element_on_screen(_query, _options)
        find_coordinate(_query, _options)
    end

    def find_element_on_screen(_query, _options = {})
        hide_soft_keyboard
        _query = include_all(_query, _options)
        MeglishLog.new.log(_query)
        wait_for_element_exists(_query, timeout: get_option(:timeout, _options))
        scroll_to_element(_query, _options)
    end

    def find_elements(_query, _options = {})
        query(include_all(_query, _options))
    end

    def get_device_size
        size = `adb shell dumpsys input | grep 'deviceSize' | awk '{ print $10 , $11 }'`
        size = size[0..size.length - 3]
        w, h = size.split(', ')
        w = w.to_i
        h = h.to_i
        [w, h]
    end

    def get_element(_query, _options = {})
        find_element_on_screen(_query, _options)
        query(include_all(_query, _options)).first
    end

    def get_element_by_index(_query, _index, _options = {})
        new_query = _query + ' index:' + _index
        find_element_on_screen(_query, _options)
        query(new_query).first
    end

    def get_elements(_query, _options = {})
        query(_query)
    rescue
        return []
    end

    def keyboard_enter_text_element(_text, _options = {})
        wait_for_keyboard
        keyboard_enter_text _text
        hide_soft_keyboard
    end

    def long_press_element(_query, _options = {})
        start_monkey
        find_element_on_screen(_query, _options)
        x, y = find_coordinate(_query, _options)
        monkey_touch(:down, x, y)
        kill_existing_monkey_processes
    end

    def long_press_release_element(_query, _options = {})
        start_monkey
        find_element_on_screen(_query, _options)
        x, y = find_coordinate(_query, _options)
        monkey_touch(:up, x, y)
        kill_existing_monkey_processes
    end

    def long_press_and_touch_element(_query, _touch_element_query, _options = {})
        long_press_element(_query, _options)
        touch_element(_touch_element_query, _options)
    end

    def set_date_element(_query_input, _date, _options = {})
        new_date = _date.match(/(^[\d]{4})\/([\d]{1,2})\/([\d]{1,2})/)
        year = new_date[1].to_i
        month = new_date[2].to_i - 1
        day = new_date[3].to_i

        touch_element(_query_input, _options)
        query('DatePicker', method_name: :updateDate, arguments: [year, month, day])
        touch("MDButton id:'md_buttonDefaultPositive'") unless get_option(:confirm_alert, _options)
    end

    def scroll_to_element(_query, _options = {})
        return unless get_option(:scroll_to_element, _options)
        sleep 0.5
        hide_soft_keyboard
        unless (query(_query).first['rect']['height']).zero? && (query(_query).first['rect']['width']).zero?
            w, h = get_device_size
            x, y = find_coordinate(include_all(_query, _options))

            scroll_until_find_element(_query, h, y, w, x)
            swipe_until_find_element(_query, w, x, h, y)
        end
    rescue
        MeglishLog.new.log('Scroll to element was ignored')
        query(_query)
    end

    def scroll_to_top
        perform_action('drag', 50, 50, 50, 1500, 1)
    end

    def select_spinner_item_element(_spinner_query, _text, _options = {})
        touch_element(_spinner_query, _options)
        touch_element("DropDownListView child CustomFontTextView text:'#{_text}'", _options)
    end

    def swipe_left(_query)
        has_element = query(_query + ' parent HorizontalScrollView')
        _query = has_element.empty? ? _query : _query + ' parent HorizontalScrollView'
        pan_left(query_string: _query)
    end

    def swipe_right(_query)
        has_element = query(_query + ' parent HorizontalScrollView')
        _query = has_element.empty? ? _query : _query + ' parent HorizontalScrollView'
        pan_right(query_string: _query)
    end

    def text_element(_query, _options = {})
        get_element(_query, _options)['text']
    end

    def text_spinner_element(_query, _options = {})
        _query += ' child CustomFontTextView'
        get_element(_query, _options)['text']
    end

    def touch_element(_query, _options = {})
        find_element_on_screen(_query, _options)
        touch(_query.strip)
    end

    def touch_element_with_all(_query, _options = {})
        find_element_on_screen(_query, _options)
        touch(include_all(_query, options).strip)
    end

    def touch_element_by_text_position(_query, _text, _options = {})
        text_el = get_element(_query, _options)['text']
        text_index = text_el.index(_text) + (_text.length / 2)
        line_for_offset = query(_query, :getLayout, getLineForOffset: text_index)[0]
        vertical = query(_query, :getLayout, getLineBaseline: line_for_offset)[0].to_i
        horizontal = query(_query, :getLayout, getPrimaryHorizontal: text_index)[0].to_i
        touch(_query, x: 0, y: 0, offset: { x: horizontal, y: vertical })
    end

    def touch_and_keyboard_text_element(_query, _text, _options = {})
        touch_element(_query.strip, _options)
        clear_text if get_option(:clear_text, _options)
        keyboard_enter_text_element(_text, _options)
    end

    def wait_for_or_ignore(_query, _timeout = 3, _options = {})
        _timeout *= 2
        found = false
        while _timeout > 0 && found == false
            if find_elements(_query, _options).empty?
                _timeout -= 1
                sleep 0.5
            else
                found = true
            end
        end
        found
    end

    def wait_for_text_element(_query, _timeout = 10, _options = {})
        count = 0
        filled = ''
        while filled.nil? || filled.empty?
            return if count >= _timeout
            filled = text_element(_query, _options)
            sleep 1
            count += 1
        end
    end

    def wait_keyboard_visible?(_timeout = 3)
        visible = 'false'
        _timeout *= 2
        while _timeout > 0 && visible == 'false'
            field, visible = `adb shell dumpsys input_method | grep mInputShown | awk '{ print $4 }'`.split('=')
            if visible == 'false'
                _timeout -= 1
                sleep 0.5
            end
        end
        visible == 'true' ? true : false
    end

    private

    def include_all(_query, _options = {})
        _query = 'all ' + _query if _query.include?('all ') == false && get_option(:include_all, _options)
        _query
    end

    def scroll_until_find_element(_query, _height, _coord_y, _width, _coord_x)
        count_times = 0
        if (_coord_y > _height / 2) && (_coord_x < _width)
            scroll_down until query(_query).first['visible'] || (count_times += 1) >= 10
        else
            scroll_up until query(_query).first['visible'] || (count_times += 1) >= 10
        end
    end

    def swipe_element(_query, _options = {})
        w, h = get_device_size
        x, y = find_coordinate(include_all(_query, _options))
        [w, h, x, y]
    end

    def swipe_until_find_element(_query, _width, _coord_x, _height, _coord_y)
        count_times = 0
        if (_coord_x > _width) && (_coord_y > _height)
            swipe_left(_query) until query(_query).first['visible'] || (count_times += 1) >= 5
        else
            swipe_left(_query) until query(_query).first['visible'] || (count_times += 1) >= 5
        end
    end

    def get_option(_option, _options)
        default_value = ENV[_option[0, _option.length].upcase]
        default_value = MELGISH_CONDITIONS[_option] if default_value.nil? || default_value.empty?
        return default_value unless has_option?(_option, _options)
        _options[_option]
    end

    def has_option?(_option, _options)
        return (_options[_option].nil? ? false : true) unless _options.nil? || _options.empty?
        false
    end
end
