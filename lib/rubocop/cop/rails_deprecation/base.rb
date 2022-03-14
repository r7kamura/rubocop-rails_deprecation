# frozen_string_literal: true

module RuboCop
  module Cop
    module Deprecation
      class Base < ::RuboCop::Cop::Base
        DEFAULT_MINIMUM_TARGET_RAILS_VERSION = 5.0

        class << self
          attr_writer :minimum_target_rails_version

          # @return [Float]
          def minimum_target_rails_version
            @minimum_target_rails_version ||= DEFAULT_MINIMUM_TARGET_RAILS_VERSION
          end

          # @note Called from `RuboCop::Cop::Team#support_target_rails_version?`.
          # @param [Float] version
          # @return [Boolean]
          def support_target_rails_version?(version)
            minimum_target_rails_version <= version
          end
        end
      end
    end
  end
end
