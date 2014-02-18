Pod::Spec.new do |s|
  s.name         = "HHURLRoute"
  s.version      = "0.0.1"
  s.summary      = "HHURLRoute."
  s.homepage     = "https://github.com/hirohisa/HHURLRoute"
  s.license      = {
                      :type => 'MIT',
                      :text => <<-LICENSE
                      LICENSE
                    }

  s.author       = {
                      "Hirohisa Kawasaki" => "hirohisa.kawasaki@gmail.com"
                    }
  s.platform     = :ios
  s.source       = {
                      :git => "https://github.com/hirohisa/HHURLRoute.git",
                      :tag => "#{s.version}"
                    }
  s.source_files = 'HHURLRoute/*.{h,m}'
  s.requires_arc = true
end
