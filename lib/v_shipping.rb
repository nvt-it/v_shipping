require 'active_support/concern'
require 'active_support/core_ext/class/attribute'

module VShipping
  extend ActiveSupport::Concern

  module ClassMethods
    @@ahamove = nil

    def ahamove
      return @@ahamove unless @@ahamove.nil?

      @@ahamove = VShipping::Setup.ahamove
    end
  end

  class << self
    def configure(&block)
      VShipping::Setup.configure(&block)
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end

require 'v_shipping/ahamove'
require 'v_shipping/setup'
