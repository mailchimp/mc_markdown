module MCMarkdown
  module CommonMisspellings

    def preprocess doc

      replacements = {
        "(&ldqou;)"  =>  "&ldquo;",
        "(&rdqou;)"  =>  "&rdquo;",
        "(&rsqou;)"  =>  "&rsquo;"
      }

      replacements.each do |bad_regex, correction|
        doc.gsub! /#{bad_regex}/xi, correction
      end

      if defined?(super)
        return super(doc)
      else
        return doc
      end
    end

  end
end