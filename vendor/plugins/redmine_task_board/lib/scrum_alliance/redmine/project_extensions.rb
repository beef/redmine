module ScrumAlliance
  module Redmine
    module ProjectExtensions
      # Note that this method is also used in the other plugins and should probably be moved (somehow).
      def current_version
        versions.last( :conditions => [ 'effective_date > ?', Date.current ] )
      end
    end # ProjectExtensions
  end # Redmine
end # ScrumAlliance
