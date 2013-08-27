require 'redcarpet'

# Util
require 'mc-markdown/extensions'
require 'mc-markdown/renderers'
require 'mc-markdown/parsers/short_tag'

# Formatters
require 'mc-markdown/formatters/common_misspellings'
require 'mc-markdown/formatters/header_with_id'
require 'mc-markdown/formatters/image'
require 'mc-markdown/formatters/links'
require 'mc-markdown/formatters/lists'
require 'mc-markdown/formatters/escape_merge_tags'
require 'mc-markdown/formatters/blockquote'
require 'mc-markdown/formatters/blocks'
require 'mc-markdown/formatters/wistia'

# Renderers
require 'mc-markdown/renderers/html'
require 'mc-markdown/renderers/base'
require 'mc-markdown/renderers/guidebook'
require 'mc-markdown/renderers/legal'