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
        match = port.match(/(\D+)(\d+)-(\d+)/)
        if match
          out.concat((match[2]..match[3]).to_a.map { |p| "#{match[1]}#{p}" })
        else
          out << port
        end
      end
      out
    end

    ##
    # Generate a single unified hash of the ports and their speeds, and return
    # a hash sorted by port number.
    #
    # = Example:
    #
    #   gen_port_hash(['swp1'], ['swp5','swp6'], ['swp10'], ['swp12'])
    #   => [[1, "40G"], [5, "10G"], [6, "10G"], [10, "4x10G"], [12, "40G/4"]]
    #
    # = Parameters:
    # speed_40g::
    #   An array of 40G ports
    # speed_10g::
    #   An array of 10G ports
    # speed_4_by_10g
    #   An array of 4x10G ports
    # speed_40g_div_4
    #   An array of 40G/4 ports
    #
    # = Returns:
    # A sorted hash of the ports and their configured speeds
    #
    def self.gen_port_hash(speed_40g = [], speed_10g = [], speed_4_by_10g = [], speed_40g_div_4 = [])
      port_hash = {}
      speed_40g.each do |port|
        match = port.match(/(\d+)/)
        if match
          port_num = match[1]
          port_hash[port_num.to_i] = '40G'
        else
          Chef::Log.info("Invalid port #{port}")
        end
      end

      speed_10g.each do |port|
        match = port.match(/(\d+)/)
        if match
          port_num = match[1]
          port_hash[port_num.to_i] = '10G'
        else
          Chef::Log.info("Invalid port #{port}")
        end
      end

      speed_4_by_10g.each do |port|
        match = port.match(/(\d+)/)
        if match
          port_num = match[1]
          port_hash[port_num.to_i] = '4x10G'
        else
          Chef::Log.info("Invalid port #{port}")
        end
      end

      speed_40g_div_4.each do |port|
        match = port.match(/(\d+)/)
        if match
          port_num = match[1]
          port_hash[port_num.to_i] = '40G/4'
        else
          Chef::Log.info("Invalid port #{port}")
        end
      end

      # Return the full hash sorted by the key (I.e. numeric order)
      port_hash.sort
    end
  end
end
