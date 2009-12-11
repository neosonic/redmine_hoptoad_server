require 'redmine'

Redmine::Plugin.register :redmine_hoptoad_server do
  name 'Hoptoad Server'
  author 'Jan Schulz-Hofen, Marcello Barnaba, Matt McMahand'
  description 'Redmine acts as an Hoptoad server with this plugin. Hoptoad is an HTTP(S) API, available at http://www.hoptoadapp.com/, to allow automatic reporting of application exceptions. This flavour of the plugin allows Redmine to receive plain-text notifications, useful if you use the Hoptoad facility for e.g. user feedbacks'
  version '0.0.3'
end
