require 'gtk3'

module Yardview
  class ApplicationWindow < Gtk::ApplicationWindow
    type_register

    def self.init
      set_template resource: '/com/github/kojix2/yardview/yardview.ui'
      bind_template_child 'box'
    end

    def initialize(application)
      # calling class method.
      self.class.set_connect_func { |handler| method(handler) }

      super application: application
      set_title 'YardView'

      start_yard_server
      create_gui
    end

    def create_gui
      signal_connect('destroy') do
        Gtk.main_quit
        Process.kill(:TERM, @yard)
        @yard = nil
      end
      at_exit { Process.kill(:TERM, @yard) unless @yard.nil? }
      @view = WebKit2Gtk::WebView.new
      @view.load_uri('http://localhost:8808')
      box.add @view, expand: true, fill: true
      @view.show
    end

    def port_open?(port)
      !system("lsof -i:#{port}", out: '/dev/null')
    end

    def on_home_clicked
      @view.load_uri('http://localhost:8808')
    end

    def on_top_clicked
      puts 'Todo: scroll up'
    end

    def on_refresh_clicked
      @view.reload
    end

    def start_yard_server
      if port_open? 8808
        @yard = spawn('yard server -g -p 8808 --reload')
        sleep 1
      else
        raise 'port 8808 is in use!'
      end
    end
  end
end
