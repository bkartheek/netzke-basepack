module Netzke::ActiveRecord::Attributes
  module ClassMethods
    
    # Define a single virtual attribute.
    # Example:
    #   netzke_virtual_attribute :recent, :type => :boolean, :read_only => true
    def netzke_virtual_attribute(name, options = {})
      options[:type] ||= :string
      virtual_attrs = (read_inheritable_attribute(:netzke_virtual_attributes) || []) << {:name => name}.merge(options)
      write_inheritable_array(:netzke_virtual_attributes, virtual_attrs)
    end
    
    # Exclude attributes from being picked up by grids and forms.
    # Accepts an array of attribute names (as symbols).
    # Example:
    #   netzke_expose_attributes :created_at, :updated_at, :crypted_password
    def netzke_exclude_attributes(*args)
      write_inheritable_array(:netzke_excluded_attributes, args)
    end
    
    # Explicitly expose attributes that should be picked up by grids and forms.
    # Accepts an array of attribute names (as symbols).
    # Takes precedence over <tt>netzke_exclude_attributes</tt>.
    # Example:
    #   netzke_expose_attributes :name, :role__name
    def netzke_expose_attributes(*args)
      write_inheritable_array(:netzke_exposed_attributes, args)
    end
    
    # Returns the attributes that will be picked up by grids and forms.
    def netzke_attributes
      exposed = read_inheritable_attribute(:netzke_exposed_attributes)
      exposed ? netzke_attrs_in_forced_order(exposed) : netzke_attrs_in_natural_order
    end
    
    private
      def netzke_virtual_attributes
        (read_inheritable_attribute(:netzke_virtual_attributes) || []).map { |attr| attr.merge(:virtual => true) }
      end
    
      def netzke_excluded_attributes
        read_inheritable_attribute(:netzke_excluded_attributes) || []
      end

      def netzke_attrs_in_forced_order(attrs)
        attrs.collect do |attr|
          netzke_virtual_attributes.detect { |va| va[:name] == attr } || {:name => attr}
        end
      end
      
      def netzke_attrs_in_natural_order
        (
          column_names.map { |name| {:name => name.to_sym} } + 
          netzke_virtual_attributes
        ).reject { |attr| netzke_excluded_attributes.include?(attr[:name]) }
      end
    
  end
  
  module InstanceMethods
    
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end