module MCMarkdown
  module Formatter
    module Links

      # Captures link classes
      # $1 => class
      # $2 => junk
      # $3 => target
      LINK_CLASSES_PATTERN = /.* \{(.*)\}\s? ( (_\w*)\s?$ )?/x

      # Captures link targets
      # $1 => junk
      # $2 => target_attr
      LINK_TARGET_PATTERN = /.* ( \{.*\}\s* )? (_\w*)\s?$/x


      # add ability to add classes to links
      # [Link Test {class} _target ](link)
      def link link, title, content

        # default classes and target to nil
        classes = nil
        target = nil

        # there is always a link
        return_string = "<a href='#{link}'"

        # check for classes or targets
        if LINK_CLASSES_PATTERN.match(content)
          match_data = LINK_CLASSES_PATTERN.match(content)

          # there is a class and maybe a target
          classes = match_data[1]
          target = match_data[3]


        elsif LINK_TARGET_PATTERN.match(content)
          match_data = LINK_TARGET_PATTERN.match(content)

          # there is a target and no class
          # (because we passed the class pattern)
          classes = nil
          target = match_data[2]

        end

        # add the target and classes params
        return_string << " class='#{classes}'" if classes
        return_string << " target='#{target}'" if target

        # remove classes and target from the content
        content.gsub!( /\s?\{#{classes}\}\s?/, "" ) if classes
        content.gsub!( /\s?#{target}\s?/, "" ) if target

        # close that tag with the content
        return_string << ">#{content}</a>"

        return return_string
      end

    end
  end
end