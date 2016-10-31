module Raws
  # Load additional classes
  ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), 'raws'))
  autoload(:VERSION, "#{APP_ROOT}/config/version")
  autoload(:Logger, "#{APP_ROOT}/utils/logger")
  autoload(:List, "#{APP_ROOT}/list")
end
