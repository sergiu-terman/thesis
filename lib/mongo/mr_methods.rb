def map(words)
  %Q{
    function() {
      var words = #{preprocess_words(words)};
      var date = this.datetime;
      var key_date = (date.getMonth() + 1) + "-" + date.getFullYear();

      for (var i = 0; i < words.length; i++) {
        if (this.content.indexOf(words[i]) >= 0) {
          emit(key_date, 1);
          break;
        }
      }
    }
  }
end

def reduce
  %Q{
    function(key, values) {
      return Array.sum(values);
    }
  }
end

def preprocess_words(words)
  words = words.map {|word| %Q["#{word.to_s}"]}
  "[" + words.join(",") + "]"
end
