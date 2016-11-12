class MeglishHelper
    def build_index(_index)
        _index.to_s.empty? ? '' : " index:#{_index} "
    end
end
