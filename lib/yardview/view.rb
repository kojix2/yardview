module Yardview
	class Viewer
		def initialize
			start_yard_server
			create_gui
			Gtk.main
		end

		def create_gui
			win = Gtk::Window.new
			win.set_default_size(800, 600)
			win.signal_connect("destroy") do 
				Gtk.main_quit
				Process.kill(:TERM, @yard)
			end
			view = WebKit2Gtk::WebView.new
			view.load_uri("http://localhost:18808")
			win.add view
			win.show_all
		end

		def start_yard_server
			@yard = spawn("yard server -g -p 18808")
			sleep 1
		end
	end
end
