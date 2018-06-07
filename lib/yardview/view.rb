module Yardview
  class Viewer
    def initialize
      start_yard_server
      create_gui
      Gtk.main
    end

    def create_gui
      bd = Gtk::Builder.new
      path = File.expand_path('../../resources/yardview.ui', __dir__)
      bd.add_from_file(path)
      win = bd.get_object('win')
      win.set_default_size(800, 600)
      win.signal_connect('destroy') do
        Gtk.main_quit
        Process.kill(:TERM, @yard)
        @yard = nil
      end
      at_exit { Process.kill(:TERM, @yard) unless @yard.nil? }
      box = bd.get_object('box')
      @view = WebKit2Gtk::WebView.new
      @view.load_uri('http://localhost:8808')
      win.add @view, expand: true, fill: true
      bd.connect_signals { |handler| method(handler) }
      win.show_all
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
        raise "port 8808 is in use!"
      end
    end
  end
end
