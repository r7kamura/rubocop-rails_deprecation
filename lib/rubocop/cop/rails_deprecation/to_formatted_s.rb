# frozen_string_literal: true

module RuboCop
  module Cop
    module RailsDeprecation
      # This cop identifies passing a format to `#to_s`.
      #
      # @safety
      #   This cop's auto-correction is unsafe because a custom or unrelated `to_s` method call would be change to `to_formatted_s`.
      #
      # @example
      #
      #   # bad
      #   to_s
      #
      #   # bad
      #   to_s(args)
      #
      #   # good
      #   to_formatted_s
      #
      #   # good
      #   to_formatted_s(args)
      #
      class ToFormattedS < Base
        extend AutoCorrector

        self.minimum_target_rails_version = 7.0

        MSG = 'Use `to_formatted_s(...)` instead of `to_s(...)`.'

        def_node_matcher :to_s_with_any_argument?, <<~PATTERN
          (send _ :to_s _ ...)
        PATTERN

        def on_send(node)
          return unless to_s_with_any_argument?(node)

          add_offense(node) do |rewriter|
            rewriter.replace(
              node.loc.selector,
              'to_formatted_s'
            )
          end
        end
      end
    end
  end
end
