namespace :rapid_ui do
  desc "Install Rapid UI"
  task :install do
    def copy_files(file, destination)
      puts "Copying #{file} to #{destination}..."

      source = File.join File.dirname(__FILE__), "../install/#{file}"
      to = Rails.root.join(destination).to_s
      FileUtils.cp_r source.to_s, to
    end

    puts "Installing Rapid Ui..."
    puts "----------------------------------------"
    copy_files("ui.yml", "config/ui.yml")
    copy_files("rapid_ui.rb", "config/initializers/rapid_ui.rb")
    copy_files("render_monkeypatch.rb", "config/initializers/render_monkeypatch.rb")
    copy_files("wrapper_component.rb", "app/components/wrapper_component.rb")
    copy_files("wrapper_component.html.slim", "app/components/wrapper_component.html.slim")
    puts "----------------------------------------"
    puts "Rapid Ui installed."
  end
end
