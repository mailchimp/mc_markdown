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
      doc
    end
  end
end