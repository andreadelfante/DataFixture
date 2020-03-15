Pod::Spec.new do |s|
  s.name             = 'DataFixture'
  s.version          = '1.1.0'
  s.summary          = 'Creation of data model easily, with no headache.'

  s.description      = <<-DESC
Creation of data model easily, with no headache. DataFixture is onvenient way to generate new data for testing / seeding your Realm Database.
                       DESC

  s.homepage         = 'https://github.com/andreadelfante/DataFixture'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'andreadelfante' => 'andreadelfante94@gmail.com' }
  s.source           = { :git => 'https://github.com/andreadelfante/DataFixture.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/a_delfante'

  s.swift_version = '5.1'

  s.cocoapods_version = '> 0.39.0'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.dependency 'Fakery'

  s.default_subspec = 'Basic'

  s.subspec 'Basic' do |b|
    b.source_files = [ 'DataFixture/Classes/**/*' ]
  end

  s.subspec 'RealmSeeder' do |r|
    r.source_files = [ 'DataFixture-RealmSeeder/Classes/**/*' ]

    r.dependency 'RealmSwift'
  end
end
