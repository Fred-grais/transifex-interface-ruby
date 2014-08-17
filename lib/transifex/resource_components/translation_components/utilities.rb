module Transifex
  module ResourceComponents
    module TranslationComponents
      module Utilities
        private
          def compute_source_entity_hash(key, context = "")
            keys = ''
            if context.is_a?(Array)
              unless context.empty?
                keys = [key] + context
              else
                keys = [key, '']
              end
            else              
              keys = [key, context]
            end
            Digest::MD5.hexdigest(keys.join(':').encode("UTF-8"))
          end
      end
    end
  end
end
