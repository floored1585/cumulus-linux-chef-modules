# Top level namespace for Cumulus Networks
module Cumulus
  # General utility functions
  module Utils
    ##
    # Take an array of ports and expand any ranges into individual items.
    #
    # = Example:
    #
    #   expand_port_list(['swp1','swp5-7', 'swp20'])
    #   => ["swp1", "swp5", "swp6", "swp7", "swp20"]
    # 
    # = Parameters:
    # list::
    #   An array of ports, some of which may be a port range
    #
    # = Returns:
    # The expanded array of ports
    #
    def self.expand_port_list(list = [])
      out = []
      list.each do |port|
        if match = port.match(/(\D+)(\d+)-(\d+)/)
          out.concat((match[2]..match[3]).to_a.map { |p| "#{match[1]}#{p}" })
        else
          out << port
        end
      end
      out
    end
  end
end
