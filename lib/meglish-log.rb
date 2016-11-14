class MeglishLog
    def log(_text)
        default_value = ENV[:meglish_log]
        default_value = default_value.nil? ? true : false
        if default_value
            puts "  >> " + _text
        end
    end
end
