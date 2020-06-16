# frozen_string_literal: true

require 'gtk3'

module Yardview
  class << self
    def application
      @@application ||= Gtk::Application.new('com.github.kojix2.yardview', :flags_none)
    end
  end
end
