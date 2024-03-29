# frozen_string_literal: true

require 'gtk3'

module YardView
  class ApplicationWindow < Gtk::ApplicationWindow
    type_register

    def self.init
      set_template resource: '/com/github/kojix2/yardview/yardview.ui'
      bind_template_child 'box'
      set_connect_func do |handler_name|
        lambda do
          YardView.application.active_window.__send__(handler_name)
        end
      end
    end

    attr_accessor :port

    def initialize(application, port: port_num)
      super application: application
      set_title 'YardView'
      set_icon GdkPixbuf::Pixbuf.new resource: '/com/github/kojix2/yardview/ruby.png'

      @port = port
      start_yard_server
      create_gui
    end

    def create_gui
      signal_connect('destroy') do
        Process.kill(:INT, @yard)
        @yard = nil
      end
      at_exit { Process.kill(:INT, @yard) unless @yard.nil? }
      @view = WebKit2Gtk::WebView.new
      @view.load_uri("http://localhost:#{port}")
      box.add @view, expand: true, fill: true
      @view.show
    end

    def port_open?(port)
      system("lsof -i:#{port}", out: '/dev/null')
    end

    def on_home_clicked
      @view.load_uri("http://localhost:#{port}")
    end

    def on_back_clicked
      @view.go_back
    end

    def on_top_clicked
      @view.run_javascript('window.scrollTo(0,0);')
    end

    def on_refresh_clicked
      @view.reload
    end

    def start_yard_server
      raise "port #{port} is in use!" if port_open? port

      @yard = spawn('yard', 'server', '-g', '-p', "#{port}", '--reload')
      sleep 1
    end
  end
end
