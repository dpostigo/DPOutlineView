Pod::Spec.new do |s|
  s.name         = "DPOutlineView"
  s.version      = "0.0.1"
  s.summary      = "DPOutlineView."
  s.homepage     = "http://dpostigo.com"
  s.license      = 'BSD'
  s.author       = { "Dani Postigo" => "dani@firstperson.is" }


  s.source       = { :git => "https://github.com/dpostigo/DPOutlineView.git", :tag => s.version.to_s }
  s.platform     = :osx, '10.8'
  s.dependency     'DPKit'
  s.dependency     'NSView-DPFrameUtils'
  s.frameworks   = 'Foundation', 'QuartzCore'


  s.requires_arc = true



  s.subspec 'Models' do |models|
    models.source_files = 'DPOutlineView/Models/*.{h,m}'
  end

  s.subspec 'Core' do |core|
    core.dependency 'DPOutlineView/Models'
    core.dependency 'DPOutlineView/Additions'
    core.source_files = 'DPOutlineView/*.{h,m}'
  end

  s.subspec 'Additions' do |additions|
    additions.dependency 'DPOutlineView/Core'
    additions.source_files = 'DPOutlineView/Additions/*.{h,m}'
  end




end
